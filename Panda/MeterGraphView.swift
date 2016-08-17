//
//  MeterGraphView.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/06.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class MeterGraphView: UIView {
    
    var _params:[Dictionary<String,AnyObject>]!
    var _end_point:CGFloat!
    var _change_point:CGFloat!
    var maxMovingPoint:CGFloat!
    
    var meterWidth:CGFloat!
    var contextHight:CGFloat!
    
    var image: UIImage!
    var isFirstDrawView:Bool!
    var currentUpMeter:String!
    let sideMargin:CGFloat = 0.0
    let hundredPercent:CGFloat = 100.0
    
    var count:Int = 0
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,params:[Dictionary<String,AnyObject>]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor();
        isFirstDrawView = true
        meterWidth = frame.width
        contextHight = frame.height
        _params = params
        _end_point = sideMargin
    }
    
    //ViewContorllerから呼び出す
    func startAnimating(params:[Dictionary<String,AnyObject>]){
        var plusParams = getPlusParams(params)
        var value:CGFloat!
        _params = plusParams.palams
        if (plusParams.movingMeter == "left") {
            value = plusParams.palams[0]["value"]! as! CGFloat
            maxMovingPoint = sideMargin + meterWidth * (value/10)
            currentUpMeter = plusParams.movingMeter
            let displayLink = CADisplayLink(target: self, selector: #selector(MeterGraphView.updateLeftMeter(_:)))
            displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        }
        if (plusParams.movingMeter == "right") {
            value = plusParams.palams[0]["value"]! as! CGFloat
            maxMovingPoint = meterWidth - (meterWidth * (value/10))
            currentUpMeter = plusParams.movingMeter
            let displayLink = CADisplayLink(target: self, selector: #selector(MeterGraphView.updateRightMeter(_:)))
            displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        }
    }
    
    //左側のメータを動かす
    func updateLeftMeter(link:AnyObject) {
        let onePercentWidth = meterWidth/hundredPercent
        _end_point = _end_point + onePercentWidth
        if(_end_point - sideMargin > maxMovingPoint) {
            link.invalidate()
            _change_point = maxMovingPoint
            print(_change_point)
            _end_point = maxMovingPoint
        }
        else{
            self.setNeedsDisplay()
        }
    }
    
    //右側のメータを動かす
    func updateRightMeter(link:AnyObject){
        let onePercentWidth = meterWidth/hundredPercent
        _end_point = _end_point - onePercentWidth
        if(_end_point - sideMargin < maxMovingPoint) {
            link.invalidate()
            _change_point = maxMovingPoint
            print(_change_point)
            _end_point = maxMovingPoint
        }
        else{
            self.setNeedsDisplay()
        }
    }
    
    //メーターの変化値を取得するメソッド
    func getPlusParams(params:[Dictionary<String,AnyObject>]) -> (palams: [Dictionary<String,AnyObject>], movingMeter: String){
        var plusParams = [Dictionary<String,AnyObject>]()
        var movingMeter: String!
        if((params[0]["value"]! as! Int) >= (_params[0]["value"]! as! Int)) {
            plusParams.append(["value":params[0]["value"]! as! Int,"color":UIColor.hex("a93c66", alpha: 1.0)])
            movingMeter = "left"
        }
        if ((params[0]["value"]! as! Int) <= (_params[0]["value"]! as! Int)) {
            plusParams.append(["value":params[1]["value"]! as! Int,"color":UIColor.hex("3ca97f", alpha: 1.0)])
            movingMeter = "right"
        }
        return (plusParams, movingMeter)
    }
    
    func getCurrentImage() -> UIImage {
        // nilだったら再度描画させる
        if image == nil {
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image!
    }
    
    //直線を引きその時のエンドポイントを返すメソッド
    func drawStraightLine(color:UIColor, context:CGContextRef, start_point:CGFloat, end_point:CGFloat) -> CGFloat {
        let cgColor:CGColorRef = color.CGColor
        CGContextSetStrokeColorWithColor(context, cgColor)
        CGContextSetLineWidth(context, contextHight)
        CGContextMoveToPoint(context, start_point, 0)
        CGContextAddLineToPoint(context, end_point, 0)
        CGContextClosePath(context)
        CGContextStrokePath(context)
        return end_point
    }
    
    //最初のグラフを作成するメソッド
    func drawFirstGraphView(rect: CGRect) {
        var start_point:CGFloat = sideMargin;
        var end_point:CGFloat = start_point;
        var max:CGFloat = 0;
        for dic : Dictionary<String,AnyObject> in _params {
            let value = CGFloat(dic["value"] as! Float)
            max += value;
        }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!;
        var num:Int = 0
        for dic : Dictionary<String,AnyObject> in _params {
            let value = CGFloat(dic["value"] as! Float)
            end_point = start_point + meterWidth * (value/max);
            num += 1
            if(num == 1) {
                //ここで片方のend_pointを変更点として取得している
                _change_point = end_point
                _end_point = _change_point
            }
            start_point = drawStraightLine(dic["color"] as! UIColor,context: context,start_point: start_point,end_point: end_point)
        }
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        image.drawInRect(self.bounds)
    }
    
    //増える方のグラフを上書きで描画するメソッド
    func drawPlusGraphView(rect: CGRect) {
        var start_point:CGFloat = sideMargin;
        var end_point:CGFloat = start_point;
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        for dic : Dictionary<String,AnyObject> in _params {
            self.count += 1
            start_point = _change_point
            end_point = maxMovingPoint
            if (currentUpMeter == "left" && end_point > _end_point) {
                    end_point = _end_point;
            }
            if (currentUpMeter == "right" && end_point < _end_point) {
                    end_point = _end_point;
            }
            start_point = drawStraightLine(dic["color"] as! UIColor,context: context,start_point: start_point,end_point: end_point)
        }
    }
    
    //Viewの描画を行う
    override func drawRect(rect: CGRect) {
        if(isFirstDrawView == true) {
            drawFirstGraphView(rect)
            isFirstDrawView = false
            return
        }
        self.getCurrentImage().drawInRect(self.bounds)
        drawPlusGraphView(rect)
    }
}

