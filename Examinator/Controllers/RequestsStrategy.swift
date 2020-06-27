//
//  RequestsStrategy.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/27/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class RequestsStrategy:ExpandableTableVC, ExpandableStrategy{
//    var tableViewDelegate: ExpandableDelegate = RequestsStrategyDelegate()
//    var tableViewDataSource: ExpandableDataSource = RequestsStrategyDS()
    var barButton: UIBarButtonItem? = nil
    var barButtonFunction: (() -> Void)? = nil
    
    
    func setupView<T>(tableViewDelegate:ExpandableDelegate,tableViewDataSource:ExpandableDataSource,barButtonTitle:String,barButtonFunction:(()->Void)?, editFunction:((Item)->Void)?,deleteFunction:((Item)->Void)?,storyboardID:String, storyboardType:T.Type){
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.reloadData()
        self.barButtonFunction = barButtonFunction

    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
