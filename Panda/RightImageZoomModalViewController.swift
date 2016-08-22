//
//  RightImageZoomModalViewController.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/22.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class RightImageZoomModalViewController: UIViewController {
    
    @IBOutlet weak var rightImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rightImageView.image = UIImage(named: Datacontent().getImageName(2, imageSide: 1))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
