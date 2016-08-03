//
//  HealthAndMedicalListViewController.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/04.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class HealthAndMedicalListViewController: BaseQuestionnaireListViewController {

    @IBOutlet weak var questionnaireCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        questionnaireCollectionView.registerNib(UINib(nibName: "BaseQuestionnaireListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        questionnaireCollectionView.delegate = self
        questionnaireCollectionView.dataSource = self
        
        // CollectionView のコンテンツに余白を付ける（下50px）
        questionnaireCollectionView.contentInset = UIEdgeInsets(top: 42, left: 0, bottom: 10, right: 0)
        // CollectionView のスクロール可能範囲に余白を付ける（下50px）
        questionnaireCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 42, left: 0, bottom: 10, right: 0)
    }
}
