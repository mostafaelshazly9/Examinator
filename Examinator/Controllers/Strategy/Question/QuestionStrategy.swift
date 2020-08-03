//
//  QuestionStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 7/3/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class QuestionStrategy:ExpandableTableVC, ExpandableStrategy{
    var tableViewDelegate: ExpandableDelegate = QuestionStrategyDelegate()
    var tableViewDataSource: ExpandableDataSource = QuestionStrategyDS()
    var barButton: UIBarButtonItem? = nil
    var barButtonFunction: (() -> Void)? = nil
    var subject:String!
    var chapter:String!

//    @IBAction func barButtonTapped(_ sender: UIBarButtonItem) {
//        AlertManager.showAlertWithTextFields(title: "Enter Chapter Info", message: "", textFieldPlaceHolders: ["Chapter Number", "Chapter Name"], target: self) { textFields in
//
//                guard textFields[0].text != nil && textFields[0].text != "" && textFields[1].text != nil && textFields[1].text != "" else { return }
//            guard let num = Int(textFields[0].text!) else {  AlertManager.showAlert(title: "Error", message: "please enter a number", target: self) ; return }
//            Chapter.createChapter(textFields[1].text!, number: num, subject: self.subject)
//            
//        }
//    }
    
    func setupView<T>(tableViewDelegate:ExpandableDelegate,tableViewDataSource:ExpandableDataSource,barButtonTitle:String,barButtonFunction:(()->Void)?, editFunction:((Item)->Void)?,deleteFunction:((Item)->Void)?,storyboardID:String, storyboardType:T.Type){
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        (self.tableViewDataSource as! QuestionStrategyDS).subject = subject
        (self.tableViewDataSource as! QuestionStrategyDS).chapter = chapter
        (self.tableViewDelegate as! QuestionStrategyDelegate).dataSource = self.tableViewDataSource as! QuestionStrategyDS
        self.tableViewDelegate.rowTapped = {
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: storyboardID) as! ProfessorRequestHandler
//            let delegate = (self.tableViewDelegate as! RequestsStrategyDelegate)
//            vc.setupView(request: delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row] as! ProfessorRequest)
//            self.present(vc, animated: true)
        }
        tableView.delegate = self.tableViewDelegate
        tableView.dataSource = self.tableViewDataSource
        tableView.reloadData()
//        self.barButtonFunction = barButtonFunction
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableViewDataSource.getItems()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.tableView.reloadData()
        }
        
    }
}
