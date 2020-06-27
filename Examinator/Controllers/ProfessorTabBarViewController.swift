//
//  ProfessorTabBarViewController.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/27/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class ProfessorTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UIViewController()
        vc1.tabBarItem.title = "Professors"
        let vc2 = ExpandableTableVC.setupView(forView: .requests)
        vc2.tabBarItem.title = "Requests"
        viewControllers = [vc1, vc2]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
