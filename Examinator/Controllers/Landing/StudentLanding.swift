//
//  StudentLanding.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/25/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit


class StudentLanding: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "StudentSubjectStrategy") as! StudentSubjectStrategy
        vc1.setupView(tableViewDelegate: SubjectStrategyDelegate(), tableViewDataSource: StudentSubjectStrategyDS(), barButtonTitle: "", barButtonFunction: nil, editFunction: nil, deleteFunction: nil, storyboardID: "QuestionStrategy", storyboardType: QuestionStrategy.self)

        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.tabBarItem.title = "Exam"
        let vc2 = UIViewController()
        vc2.tabBarItem.title = "Past Exams"
        viewControllers = [nav1, vc2]
    }

}
