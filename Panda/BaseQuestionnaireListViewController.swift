//
//  BaseQuestionnaireListViewController.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/03.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class BaseQuestionnaireListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    let reuseIdentifier = "BaseQuestionnaireListCollectionViewCell"
    let cellHorizontalMargin:CGFloat = 10.0
    let cellVerticalMargin:CGFloat = 5.0
    
    var itemsCount: Int?
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "質問一覧"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        //tabbarとCollectionViewの最後がかぶらないように
        if self.respondsToSelector(Selector("edgesForExtendedLayout")) {
            self.edgesForExtendedLayout = UIRectEdge.None
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.itemsCount = Datacontent().getItemsCount()
        return self.itemsCount!
        //            questionArray.count
    }
    
    //セルの大きさをきめるメソッド
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //セルのwidthは端末に合わせて計算。
        let cellWidth:CGFloat = self.view.frame.width - 2*cellHorizontalMargin
        let cellHight:CGFloat = cellWidth/2 + 50
        return CGSizeMake(cellWidth, cellHight)
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellVerticalMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellHorizontalMargin
    }
    
    
    //セルのテキストや色を指定するメソッド
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : BaseQuestionnaireListCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BaseQuestionnaireListCollectionViewCell
        
        let LeftImage = UIImage(named: Datacontent().getImageName(indexPath.row, imageSide: 0))
        let RightImage = UIImage(named: Datacontent().getImageName(indexPath.row, imageSide: 1))
        cell.collectionViewLeftImage.image = LeftImage
        cell.collectionViewRightImage.image = RightImage
        cell.collectionViewQuestionnaireLabel.text = Datacontent().getTitle(indexPath.row)
        //cellに影をつける
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSizeMake(0.0, 1.0)
        cell.layer.shadowOpacity = 0.9
        cell.layer.shadowRadius = 1.0
        return cell
    }
    
    //セルが選択された時に呼び出される。
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let baseQuestionnaireViewController: BaseQuestionnaireViewController = BaseQuestionnaireViewController()
//        baseQuestionnaireViewController.indexRowAccessor = indexPath.row
//        self.navigationController!.pushViewController(baseQuestionnaireViewController, animated: true)
        print("Num: \(indexPath.row)")
    }
}
