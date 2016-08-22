//
//  QuestionImageZoomPageViewController.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/22.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class QuestionImageZoomPageViewController: UIPageViewController {
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : AnyObject]?) {
        
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .Forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
    func getFirst() -> LeftImageZoomModalViewController {
        let firstView = LeftImageZoomModalViewController()
        return firstView
    }
    
    func getSecond() -> RightImageZoomModalViewController {
        let secoundView = RightImageZoomModalViewController()
        return secoundView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension QuestionImageZoomPageViewController : UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(RightImageZoomModalViewController) {
            // 2 -> 1
            return getFirst()
        } else {
            // 1 -> end of the road
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(LeftImageZoomModalViewController) {
            // 1 -> 2
            return getSecond()
        } else {
            // 2 -> end of the road
            return nil
        }
   }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 2
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}