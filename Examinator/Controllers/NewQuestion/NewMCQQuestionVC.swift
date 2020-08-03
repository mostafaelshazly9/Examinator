//
//  NewMCQQuestionVC.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 8/3/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class NewMCQQuestionVC:UIViewController{
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var rightAnswerTextField: UITextField!
    @IBOutlet var wrongAnswerTextFields: [UITextField]!
    @IBOutlet weak var categorySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard !questionTextView.text.isEmpty, rightAnswerTextField.text != nil, !rightAnswerTextField.text!.isEmpty,
            wrongAnswerTextFields[0].text != nil,
            wrongAnswerTextFields[1].text != nil,
            wrongAnswerTextFields[2].text != nil,
            !wrongAnswerTextFields[0].text!.isEmpty, !wrongAnswerTextFields[1].text!.isEmpty, !wrongAnswerTextFields[2].text!.isEmpty else { return }
        var wrongAnswers = [String]()
        wrongAnswerTextFields.forEach{ wrongAnswers.append($0.text!) }
        Question.createQuestion(questionTextView.text,
                                correctAnswer: rightAnswerTextField.text!,
                                wrongAnswers: wrongAnswers,
                                chapter: (navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 3] as! QuestionStrategy).chapter,
                                subject: (navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 3] as! QuestionStrategy).subject,
                                qType: .MCQ,
                                category: Question.Category(rawValue: categorySegmentControl.titleForSegment(at: categorySegmentControl.selectedSegmentIndex)!)!)
        AlertManager.showAlert(title: "Success", message: "Question Added", target: self)
        clear()
        
    }
    
    func clear(){
        questionTextView.text = ""
        rightAnswerTextField.text = ""
        wrongAnswerTextFields[0].text = ""
        wrongAnswerTextFields[1].text = ""
        wrongAnswerTextFields[2].text = ""
        
    }
    
}
