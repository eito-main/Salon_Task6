//
//  Model.swift
//  Salon_Task6
//
//  Created by 相良 詠斗 on 2021/07/25.
//

//Intのランダムな値を保持
//ランダムな値の生成

import Foundation

extension Notification.Name {
    static let didChangeRandomNumModelthemeNum = Notification.Name("didChangeRandomNumModelthemeNum")
}

class RandomNumModel {
    
    let notificationCenter = NotificationCenter()
    private var answerValue:Int = 50 {
        didSet{
            notificationCenter.post(
                name: .didChangeRandomNumModelthemeNum,
                object: answerValue
            )
        }
    }
    
    func gemerateAnswerValue(){
        answerValue = Int(arc4random_uniform(101))
    }
}
