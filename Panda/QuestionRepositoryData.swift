//
//  UserRepositorydata.swift
//  Panda
//
//  Created by 矢野史洋 on 2016/08/09.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import Foundation

class QuestionRepositoryData: QuestionRepository {

    func question(questionID: NSInteger) -> Question {
        let question = Question()
        question.title = Datacontent().getTitle(1)
        question.desc = Datacontent().getQuestionDescription(1)
        question.imageLeftUrl = Datacontent().getImageName(1, imageSide: 0)
        question.imageRightUrl = Datacontent().getImageName(1, imageSide: 1)
        
        //TODO: ユーザ情報をどこかから取得する
        return question
    }
}
