//
//  lineUpModalViewController.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/06.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class LeftImageZoomModalViewController: UIViewController {
    
    @IBOutlet weak var leftImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftImageView.image = UIImage(named: Datacontent().getImageName(2, imageSide: 0))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

