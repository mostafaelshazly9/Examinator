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
        vc1.tabBarItem.title = "Subjects"
        let vc2 = UIViewController()
        vc2.tabBarItem.title = "Exam Structure"
        let vc3 = UIViewController()
        vc3.tabBarItem.title = "Results"
        viewControllers = [vc1, vc2, vc3]

    }
    
}
