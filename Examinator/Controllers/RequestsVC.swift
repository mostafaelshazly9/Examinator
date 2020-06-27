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
        print("going to new vc")
        let vc = ExpandableTableVC.setupView(forView: .requests)
        vc.view.backgroundColor = .red
        present(vc, animated: true)
        print("new vc loaded")
    }
}
