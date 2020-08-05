//
//  ExamStructure.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/17/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct ExamStructure{
    static let ref = Database.database().reference(withPath: "ExamStructure")
    var subject:String
    var totalQuestions: Int {
        var sum = 0
        self.questionsPerChapter.forEach{ questionSet in
            questionSet.forEach{ sum += $0 }
        }
        return sum
    }
    let time:Int
    var chapterCount:Int {
        get{
            return questionsPerChapter.count
        }
    }
    let categories = ["A", "B", "C"]
    let qTypes = ["TF","MCQ"]
    var questionsPerChapter:[[Int]]
    //Questions come in the form of 6 questions per list per chapter in the following order: A-TF, A-MCQ, B-TF, B-MCQ, C-TF, C-MCQ
    
    static func createStructure(forSubject subject:String, allowedTime time:Int, chapters:[String], questionsPerChapter:[[Int]]){
        for (i,questions) in questionsPerChapter.enumerated(){
        let uuid = UUID().uuidString
        let dict = [
            "id": uuid,
            "time": time,
            "chapter":chapters[i],
            "subject": subject,
            "A-TF":questions[0],
            "A-MCQ":questions[1],
            "B-TF":questions[2],
            "B-MCQ":questions[3],
            "C-TF":questions[4],
            "C-MCQ":questions[5]
            ] as [String : Any]
        
        ref.child(uuid).setValue(dict)
    }
    }

    
    
}
