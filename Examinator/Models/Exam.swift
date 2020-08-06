//
//  Exam.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/17/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Exam{
    static let ref = Database.database().reference(withPath: "Exam")
    
    let id:String
    let subject:String
    let structure:ExamStructure
    var questions = [Question]()
    let timeStarted:Double
    var timeElapsed:Double {
        Date().timeIntervalSince1970 - timeStarted
    }
    let type:ExamType
    let student:String
    var chosenAnswers:[String:String]
    var score:Double {
        var tfs:Double = 0
        var mcqs:Double = 0
        if questions.filter({ $0.qType == .TF }).count != 0{
            tfs = Double(questions.filter{ $0.qType == .TF && $0.isAnswerTrue(answer: chosenAnswers[$0.id] ?? "")}.count) / Double(questions.filter{ $0.qType == .TF }.count)
        }
        if questions.filter({ $0.qType == .MCQ }).count != 0{
            mcqs = Double(questions.filter{ $0.qType == .MCQ && $0.isAnswerTrue(answer: chosenAnswers[$0.id] ?? "")}.count) / Double(questions.filter{ $0.qType == .MCQ }.count)
        }
        return ((tfs * 1/3) + (mcqs * 2/3)) * 100
        
        
    }
    
    enum ExamType:String{
        case practice, midterm, final
    }
    
    static func generateQuestions(fromExamStructure examStructure:ExamStructure, successHandler: @escaping (_ questions:[Question])->Void){
        Question.getQuestions(forSubject: examStructure.subject) { questions in
            var result = [Question]()
            for i in 0..<examStructure.chapters.count{
                result.append(contentsOf: questions.filter{ $0.chapter ==  examStructure.chapters[i] && $0.category == .A && $0.qType == .TF }.shuffled()[0..<examStructure.questionsPerChapter[i][0]])
                result.append(contentsOf: questions.filter{ $0.chapter ==  examStructure.chapters[i] && $0.category == .A && $0.qType == .MCQ }.shuffled()[0..<examStructure.questionsPerChapter[i][1]])
                result.append(contentsOf: questions.filter{ $0.chapter ==  examStructure.chapters[i] && $0.category == .B && $0.qType == .TF }.shuffled()[0..<examStructure.questionsPerChapter[i][2]])
                result.append(contentsOf: questions.filter{ $0.chapter ==  examStructure.chapters[i] && $0.category == .B && $0.qType == .MCQ }.shuffled()[0..<examStructure.questionsPerChapter[i][3]])
                result.append(contentsOf: questions.filter{ $0.chapter ==  examStructure.chapters[i] && $0.category == .C && $0.qType == .TF }.shuffled()[0..<examStructure.questionsPerChapter[i][4]])
                result.append(contentsOf: questions.filter{ $0.chapter ==  examStructure.chapters[i] && $0.category == .C && $0.qType == .MCQ }.shuffled()[0..<examStructure.questionsPerChapter[i][5]])
            }
            successHandler(result)
        }
    }
    
    static func generateExam(forSubject subject:String, ofType type:ExamType, successHandler: @escaping (_ questions:[Question])->Void){
        let student = User.currentUser.id
        ExamStructure.getStructure(forSubject: subject) { examStructure in
            guard let examStructure = examStructure else { return }
            generateQuestions(fromExamStructure: examStructure) { questions in
                let exam = Exam(id: UUID().uuidString,
                            subject: examStructure.subject,
                            structure: examStructure,
                            questions: questions,
                            timeStarted: Date().timeIntervalSince1970,
                            type: type,
                            student: student,
                            chosenAnswers: [String : String]())
                
                let questionIDs = exam.questions.map{ $0.id }
                let dict = [
                    "id": exam.id,
                    "subject": subject,
                    "structure":exam.structure.id,
                    "questions":questionIDs,
                    "timeStarted":exam.timeStarted,
                    "type": exam.type.rawValue,
                    "student": student,
                    "chosenAnswers": exam.chosenAnswers
                    ] as [String : Any]
                
                ref.child(exam.id).setValue(dict)
                successHandler(exam.questions)
            }
        }
        
        
        
        
        
    }
    
    
    //TODO:- Get questions based on structure
    //    func getQuestions()->[Question]{
    //
    //    }
    
    //    init(<#parameters#>) {
    //        <#statements#>
    //    }
    
}
