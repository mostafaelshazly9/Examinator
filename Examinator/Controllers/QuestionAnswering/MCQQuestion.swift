//
//  MCQQuestion.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 8/6/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class MCQQuestion:UIViewController{
    var question:Question!
    var isEnabled = true
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet var answerTextFields: [UITextField]!
    @IBOutlet weak var answerSegmentControl: UISegmentedControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    @IBAction func answerSegmentControlValueChanged(_ sender: UISegmentedControl) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerSegmentControl.isEnabled = isEnabled
        saveButton.isEnabled = isEnabled
        if !isEnabled{
            saveButton = nil
        }
        questionTextView.text = question.question
        for i in 0..<question.answers.count{
            answerTextFields[i].text = question.answers[i]
        }
    }
    
}
