//
//  Question.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/17/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Question:Item{
    static let ref = Database.database().reference(withPath: "Question")
    
    enum QType:String {
        case MCQ
        case TF
    }
    enum Category:String {
        case A,B,C
    }
    
    var id: String = ""
    let question:String!
    let correctAnswer:String!
    var wrongAnswers = [String]()
    let chapter:String!
    let qType:QType!
    let category:Category!
    var title: String { question }
    var subtitle: String { qType.rawValue }
    
    init(id:String = UUID().uuidString, question:String, type:QType, correctAnswer:String, wrongAnswers:[String], chapter:String, category:Category) {
        self.id = id
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
    
    
    static func createQuestion(_ question:String, correctAnswer:String, wrongAnswers:[String], chapter:String, subject:String, qType:QType, category: Category){
        let uuid = UUID().uuidString
        let dict = [
            "id": uuid,
            "question": question,
            "correctAnswer":correctAnswer,
            "wrongAnswers":wrongAnswers,
            "chapter":chapter,
            "subject": subject,
            "qType": qType.rawValue,
            "category": category.rawValue
            ] as [String : Any]
        
        ref.child(uuid).setValue(dict)
    }
    
    
    static func getQuestions(forSubject subject:String, forChapter chapter:String, successHandler: @escaping (_ questions:[Question])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            var questions = [Question]()
            if dataSnapShot.exists() == false {return}
            for child in dataSnapShot.children{
                let question = (child as! DataSnapshot).value  as! [String: Any]
                if question["subject"] as! String == subject && question["chapter"] as! String == chapter{
                    let newQuestion = Question(id: question["id"] as! String,
                                               question: question["question"] as! String,
                                               type: QType(rawValue: question["qType"] as! String)!,
                                               correctAnswer: question["correctAnswer"] as! String,
                                               wrongAnswers: question["wrongAnswers"] as! [String],
                                               chapter: question["chapter"] as! String,
                                               category: Category(rawValue: question["category"] as! String) ?? Category.A)
                    questions.append(newQuestion)
                }
                successHandler(questions)
                
                
            }
        }
    }
    
    static func getQuestionsNumbers(forSubject subject:String, forChapter chapter:String, successHandler: @escaping (_ numbers:[Int])->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            var A_TF = 0
            var A_MCQ = 0
            var B_TF = 0
            var B_MCQ = 0
            var C_TF = 0
            var C_MCQ = 0
            if dataSnapShot.exists() == false {return}
            for child in dataSnapShot.children{
                let question = (child as! DataSnapshot).value  as! [String: Any]
                if question["subject"] as! String == subject && question["chapter"] as! String == chapter{
                    switch (question["category"] as! String, question["qType"] as! String) {
                    case ("A", "TF"):
                        A_TF += 1
                    case ("B", "TF"):
                        B_TF += 1
                    case ("C", "TF"):
                        C_TF += 1
                    case ("A", "MCQ"):
                        A_MCQ += 1
                    case ("B", "MCQ"):
                        B_MCQ += 1
                    case ("C", "MCQ"):
                        C_MCQ += 1
                        
                    default:
                        print("Error")
                    }
                }
                successHandler([
                    A_TF,
                    A_MCQ,
                    B_TF,
                    B_MCQ,
                    C_TF,
                    C_MCQ
                ])
                
                
            }
        }
    }
    
    
}
