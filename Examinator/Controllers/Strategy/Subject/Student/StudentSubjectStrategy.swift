//
//  StudentSubjectStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 8/6/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class StudentSubjectStrategy:SubjectStrategy{
    override func setupView<T>(tableViewDelegate: ExpandableDelegate, tableViewDataSource: ExpandableDataSource, barButtonTitle: String, barButtonFunction: (() -> Void)?, editFunction: ((Item) -> Void)?, deleteFunction: ((Item) -> Void)?, storyboardID: String, storyboardType: T.Type) {
        self.tableViewDataSource = StudentSubjectStrategyDS()
        (self.tableViewDataSource as! SubjectStrategyDS).tableView = tableView
        super.setupView(tableViewDelegate: tableViewDelegate, tableViewDataSource: tableViewDataSource, barButtonTitle: barButtonTitle, barButtonFunction: barButtonFunction, editFunction: editFunction, deleteFunction: deleteFunction, storyboardID: storyboardID, storyboardType: storyboardType)
                self.tableViewDelegate.rowTapped = {
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "QuestionStrategy") as! QuestionStrategy
                    let delegate = (self.tableViewDelegate as! SubjectStrategyDelegate)
                    vc.subject = delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row].id
                    vc.setupView(tableViewDelegate: QuestionStrategyDelegate(), tableViewDataSource: StudentQuestionStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "", storyboardType: ExpandableTableVC.self)
                    vc.tableViewDelegate.rowTapped = {
                        if ((vc.tableViewDelegate as! QuestionStrategyDelegate).dataSource.items[vc.tableView.indexPathForSelectedRow!.row] as! Question).qType == .MCQ{
                            let vc2 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "MCQQuestion") as! MCQQuestion
                            let delegate = (vc.tableViewDelegate as! QuestionStrategyDelegate)
                            vc2.question = delegate.dataSource.items[vc.tableView.indexPathForSelectedRow!.row] as! Question
                            vc.navigationController?.pushViewController(vc2, animated: true)
                        }else{
                            let vc2 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "TFQuestion") as! TFQuestion
                            let delegate = (vc.tableViewDelegate as! QuestionStrategyDelegate)
                            vc2.question = delegate.dataSource.items[vc.tableView.indexPathForSelectedRow!.row] as! Question
                            vc.navigationController?.pushViewController(vc2, animated: true)
                        }
//                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "QuestionStrategy") as! QuestionStrategy
//                        let delegate = (self.tableViewDelegate as! SubjectStrategyDelegate)
//                        vc.subject = delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row].id
//                        vc.setupView(tableViewDelegate: QuestionStrategyDelegate(), tableViewDataSource: StudentQuestionStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "", storyboardType: ExpandableTableVC.self)

                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
        self.tableViewDataSource = StudentSubjectStrategyDS()
        (self.tableViewDataSource as! SubjectStrategyDS).tableView = tableView


    }

}
