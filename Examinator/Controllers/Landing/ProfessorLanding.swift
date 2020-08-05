//
//  ProfessorLanding.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 6/25/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit


class ProfessorLanding: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        getRequestState()
    }
    
    private func getRequestState(){
        ProfessorRequest.getRequest(forProfessor: User.currentUser.email) { request in
            if request.state == "pending"{
                AlertManager.showAlert(title: "Request Pending", message: "The admin has not yet reviewed your request to join", target: self)
            }
            else if request.state == "rejected"{
                AlertManager.showAlert(title: "Request Rejected", message: "The admin has rejected your joining request", target: self)
            }
            else if request.state == "accepted"{
                self.loadVCs()
            }

        }
    }
    
    private func loadVCs(){
        let vc1 = ExpandableTableVC.setupView(forView: .subjects)
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.tabBarItem.title = "Subjects"
        let vc2 = ExpandableTableVC.setupView(forView: .subjects)
        (vc2 as! SubjectStrategy).tableViewDelegate.rowTapped = {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ExamStructureVC") as! ExamStructureVC
            let delegate = ((vc2 as! SubjectStrategy).tableViewDelegate as! SubjectStrategyDelegate)
            vc.subject = delegate.dataSource.items[(vc2 as! SubjectStrategy).tableView.indexPathForSelectedRow!.row].id
            vc2.navigationController?.pushViewController(vc, animated: true)
        }
        let nav2 = UINavigationController(rootViewController: vc2)
        nav2.tabBarItem.title = "Exam Structure"
        let vc3 = UIViewController()
        vc3.tabBarItem.title = "Results"
        viewControllers = [nav1, nav2, vc3]

    }
    
}
