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
    var id:String = UUID().uuidString
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
    var chapters = [String]()
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
    static func getStructure(forSubject subject:String, successHandler: @escaping (_ examStructure:ExamStructure?)->Void){
        self.ref.observeSingleEvent(of: .value) { (dataSnapShot) in
            if dataSnapShot.exists() == false {return}
            var examStructures = [ExamStructure]()
            var questionsPerChapter = [String:[Int]]()
            var chapters = [String]()
            for child in dataSnapShot.children{
                let examStructure = (child as! DataSnapshot).value  as! [String: Any]
                if examStructure["subject"] as! String == subject{
                    let newExamStructure = ExamStructure(id: examStructure["id"] as! String,
                                                         subject: examStructure["subject"] as! String,
                                                         time: examStructure["time"] as! Int,
                                                         questionsPerChapter: [[Int]]())
                    let newQuestionsPerChapter = [
                        examStructure["A-TF"] as! Int,
                        examStructure["A-MCQ"] as! Int,
                        examStructure["B-TF"] as! Int,
                        examStructure["B-MCQ"] as! Int,
                        examStructure["C-TF"] as! Int,
                        examStructure["C-MCQ"] as! Int
                        
                    ]
                    let newChapter = examStructure["chapter"] as! String
                    chapters.append(newChapter)
                    examStructures.append(newExamStructure)
                    questionsPerChapter[newChapter] = newQuestionsPerChapter
                }

                
            }
            for _ in chapters{
                Chapter.getChapters(forSubject: subject) { newChapters in
                    let orderedChapters = newChapters.filter { chapters.contains($0.id) }.sorted { $0.number < $1.number }
                    var orderedQuestionsPerChapter = [[Int]]()
                    for chapter in orderedChapters{
                        orderedQuestionsPerChapter.append(questionsPerChapter[chapter.id] ?? [Int]())
                    }
                    examStructures[0].questionsPerChapter = orderedQuestionsPerChapter
                    examStructures[0].chapters = orderedChapters.map{ $0.id }
                    successHandler(examStructures[0])
                }
            }
        }
    }
    
}
