//
//  ProfessorSubjectStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 7/3/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class ProfessorSubjectStrategy: SubjectStrategy{
    override func setupView<T>(tableViewDelegate: ExpandableDelegate, tableViewDataSource: ExpandableDataSource, barButtonTitle: String, barButtonFunction: (() -> Void)?, editFunction: ((Item) -> Void)?, deleteFunction: ((Item) -> Void)?, storyboardID: String, storyboardType: T.Type) {
        super.setupView(tableViewDelegate: tableViewDelegate, tableViewDataSource: tableViewDataSource, barButtonTitle: barButtonTitle, barButtonFunction: barButtonFunction, editFunction: editFunction, deleteFunction: deleteFunction, storyboardID: storyboardID, storyboardType: storyboardType)
                self.tableViewDelegate.rowTapped = {
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: storyboardID) as! ChapterStrategy
                    let delegate = (self.tableViewDelegate as! SubjectStrategyDelegate)
                    vc.subject = delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row].id
                    vc.setupView(tableViewDelegate: ChapterStrategyDelegate(), tableViewDataSource: ChapterStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "", storyboardType: ExpandableTableVC.self)
                    self.navigationController?.pushViewController(vc, animated: true)
                }

    }
}
