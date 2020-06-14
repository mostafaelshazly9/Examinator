//
//  ExamStructure.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/17/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import Foundation

struct ExamStructure{
    var totalQuestions: Int {
        var sum = 0
        self.questionsPerChapter.forEach{ questionSet in
            questionSet.forEach{ sum += $0 }
        }
        return sum
    }
    let time:Int
    var chapters:[Int]
    let categories = ["A", "B", "C"]
    let qTypes = ["TF","MCQ"]
    var questionsPerChapter:[[Int]]
    //Questions come in the form of 6 questions per list per chapter in the following order: A-TF, A-MCQ, B-TF, B-MCQ, C-TF, C-MCQ
    
    
    
}
