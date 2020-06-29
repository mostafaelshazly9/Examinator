//
//  RequestsVC.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/27/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class RequestsVC:UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = ExpandableTableVC.setupView(forView: .requests)
        present(vc, animated: true)
    }
}
