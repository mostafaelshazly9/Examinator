//
//  AdminLanding.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/21/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class AdminLanding: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UIViewController()
        vc1.tabBarItem.title = "Subjects"
        let vc2 = UIViewController()
        vc2.tabBarItem.title = "Exam Structure"
        let vc3 = UIViewController()
        vc3.tabBarItem.title = "Results"
        let vc4 = ProfessorTabBarViewController()
        vc4.tabBarItem.title = "Professors"
        
        let vc5 = ExpandableTableVC.setupView(forView: .levels)
        let nav5 = UINavigationController(rootViewController: vc5)
        nav5.tabBarItem.title = "Levels"
        viewControllers = [vc1, vc2, vc3, vc4, nav5]
    }

}
