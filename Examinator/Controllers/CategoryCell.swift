//
//  CategoryCell.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 8/4/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class CategoryCell:UITableViewCell{
    var vc:ExamStructureVC!
    var index = 0
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var categoryStepper: UIStepper!
    @IBAction func valueChanged(_ sender: UIStepper, forEvent event: UIEvent) {
        if Int(currentLabel.text!)! > Int(sender.value){
            vc.totalQuestions -= 1
        }else{
            vc.totalQuestions += 1
        }
        currentLabel.text = String(Int(sender.value))
        vc.questionNumbers[index] = Int(sender.value)
    }
    
    
}
