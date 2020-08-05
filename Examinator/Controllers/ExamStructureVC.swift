//
//  ExamStructureVC.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 8/4/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit
import Combine

class ExamStructureVC:UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var numberOfQuestionsTextField: UITextField!
    @IBOutlet weak var minutesAllowedTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var labels = [
        "A-T&F",
        "A-MCQ",
        "B-T&F",
        "B-MCQ",
        "C-T&F",
        "C-MCQ"
    ]
    var subject = ""
    var numbers = [Int]()
    lazy var questionNumbers = Array(repeating: 0, count: numbers.count)
    var chapters = [Chapter]()
    var subscriptions = Set<AnyCancellable>()
    var totalQuestions = 0 {
        didSet{
            numberOfQuestionsTextField.text = String(totalQuestions)
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard minutesAllowedTextField.text != nil, !minutesAllowedTextField.text!.isEmpty,
            numberOfQuestionsTextField.text != nil, !numberOfQuestionsTextField.text!.isEmpty else { return }
        var nums = [[Int]]()
        for i in stride(from: 0, to: questionNumbers.count, by: 6){
            var temp = [Int]()
            temp.append(questionNumbers[i])
            temp.append(questionNumbers[i + 1])
            temp.append(questionNumbers[i + 2])
            temp.append(questionNumbers[i + 3])
            temp.append(questionNumbers[i + 4])
            temp.append(questionNumbers[i + 5])
            nums.append(temp)
        }
        var chapterIDs = [String]()
        chapters.forEach{ chapterIDs.append($0.id) }
        ExamStructure.createStructure(forSubject: subject, allowedTime: Int(minutesAllowedTextField.text!)!, chapters: chapterIDs, questionsPerChapter: nums)
        AlertManager.showAlert(title: "Success", message: "Exam Structure Saved", target: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        Chapter.getChapters(forSubject: self.subject) { chapters in
            self.chapters = chapters.sorted { $0.number < $1.number }
            self.numbers = Array(repeating: 0, count: chapters.count * 6)
            for chapter in chapters{
                Question.getQuestionsNumbers(forSubject: self.subject, forChapter: chapter.id) { nums in
                    self.numbers[((chapter.number - 1) * 6)] = nums[0]
                    self.numbers[((chapter.number - 1) * 6) + 1] = nums[1]
                    self.numbers[((chapter.number - 1) * 6) + 2] = nums[2]
                    self.numbers[((chapter.number - 1) * 6) + 3] = nums[3]
                    self.numbers[((chapter.number - 1) * 6) + 4] = nums[4]
                    self.numbers[((chapter.number - 1) * 6) + 5] = nums[5]
//                    self.numbers.replaceSubrange(((chapter.number - 1) * 6)..<((chapter.number - 1) * 6) + 6, with: nums)
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        if chapters.count != 0{
            let label = chapters[Int(indexPath.row / 6)].name + " - " + labels[indexPath.row % 6]
            cell.categoryLabel.text = label
            cell.categoryStepper.maximumValue = Double(numbers[indexPath.row])
            cell.vc = self
            cell.index = indexPath.row
        }
        return cell
    }
    
}
