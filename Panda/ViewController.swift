//
//  ViewController.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/03.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var usecase: QuestionUsecase!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        let dataRepository = QuestionRepositoryData()
        self.usecase = QuestionUsecase(repository: dataRepository)
        let question = self.usecase.getQuestion(1)
        print("\(question.title)")
        print("\(question.desc)")
        print("\(question.imageLeftUrl)")
        print("\(question.imageRightUrl)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

