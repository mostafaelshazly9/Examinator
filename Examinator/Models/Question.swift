//
//  Question.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/17/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation

class Question{
    
    enum QType {
        case MCQ
        case TF
    }
    enum Category:String {
        case A,B,C
    }
    
    let question:String!
    let correctAnswer:String!
    var wrongAnswers = [String]()
    let chapter:Int!
    let qType:QType!
    let category:Category!
    
    init(question:String, type:QType, correctAnswer:String, wrongAnswers:[String], chapter:Int, category:Category) {
        self.question = question
        self.qType = type
        self.correctAnswer = correctAnswer
        self.wrongAnswers = wrongAnswers
        self.chapter = chapter
        self.category = category
    }
    
    func getShuffledAnswers() -> [String] {
        switch qType {
        case .MCQ:
            wrongAnswers.append(correctAnswer)
            return wrongAnswers.shuffled()
        case .TF:
            return ["True", "False"]
        case .none:
            print("Error")
            return ["Error"]
        }
    }
    
    func isAnswerTrue(answer:String) -> Bool{
        return answer == correctAnswer
    }
    
}
