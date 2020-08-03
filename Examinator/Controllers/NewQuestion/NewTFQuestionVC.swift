//
//  NewTFQuestionVC.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 8/3/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class NewTFQuestionVC:UIViewController{
    @IBOutlet weak var sentenceTextView: UITextView!
    @IBOutlet weak var truthSegmentControl: UISegmentedControl!
    @IBOutlet weak var categorySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard !sentenceTextView.text.isEmpty else { return }
        Question.createQuestion(sentenceTextView.text,
                                correctAnswer: truthSegmentControl.titleForSegment(at: truthSegmentControl.selectedSegmentIndex)!,
                                wrongAnswers: (truthSegmentControl.selectedSegmentIndex == 0) ? ["False"] : ["True"],
                                chapter: (navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 3] as! QuestionStrategy).chapter,
                                subject: (navigationController?.viewControllers[(navigationController?.viewControllers.count)! - 3] as! QuestionStrategy).subject,
                                qType: .TF,
                                category: Question.Category(rawValue: categorySegmentControl.titleForSegment(at: categorySegmentControl.selectedSegmentIndex)!)!)
        AlertManager.showAlert(title: "Success", message: "Question Added", target: self)
        sentenceTextView.text = ""

    }
    
}
