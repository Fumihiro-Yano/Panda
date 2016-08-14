//
//  QuestionUsecase.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/09.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import Foundation

class QuestionUsecase: NSObject {
    
    let repository: QuestionRepository
    
    init(repository: QuestionRepository) {
        self.repository = repository
        super.init()
    }
    
    //メールアドレスを取得する
    func getQuestion(questionID: NSInteger) -> Question {
        return repository.question(questionID)
    }
}
