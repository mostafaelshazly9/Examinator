//
//  RequestsStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/27/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class RequestsStrategy:ExpandableTableVC, ExpandableStrategy{
    var tableViewDelegate: ExpandableDelegate = RequestsStrategyDelegate()
    var tableViewDataSource: ExpandableDataSource = RequestsStrategyDS()
    var barButton: UIBarButtonItem? = nil
    var barButtonFunction: (() -> Void)? = nil
    
    
    func setupView<T>(tableViewDelegate:ExpandableDelegate,tableViewDataSource:ExpandableDataSource,barButtonTitle:String,barButtonFunction:(()->Void)?, editFunction:((Item)->Void)?,deleteFunction:((Item)->Void)?,storyboardID:String, storyboardType:T.Type){
        self.tableViewDelegate = tableViewDelegate
        self.tableViewDataSource = tableViewDataSource
        (self.tableViewDelegate as! RequestsStrategyDelegate).dataSource = self.tableViewDataSource as! RequestsStrategyDS
        self.tableViewDelegate.rowTapped = {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: storyboardID) as! ProfessorRequestHandler
            let delegate = (self.tableViewDelegate as! RequestsStrategyDelegate)
            vc.setupView(request: delegate.dataSource.items[self.tableView.indexPathForSelectedRow!.row] as! ProfessorRequest)
            self.present(vc, animated: true)
        }
        tableView.delegate = self.tableViewDelegate
        tableView.dataSource = self.tableViewDataSource
        tableView.reloadData()
        self.barButtonFunction = barButtonFunction
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableViewDataSource.getItems()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.tableView.reloadData()
        }
        
    }
}
