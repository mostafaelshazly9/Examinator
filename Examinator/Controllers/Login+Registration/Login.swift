//
//  Login.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/21/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit
//import Firebase
//import FirebaseDatabase

class Login:UIViewController{
//    let ref = Database.database().reference(withPath: "users")
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        User.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "", successHandler: { user in
            switch self.storyboard?.instantiateViewController(withIdentifier: "\(user.type.rawValue)Landing") {
            case let adminVC as AdminLanding:
                adminVC.modalPresentationStyle = .fullScreen
                self.present(adminVC,animated: true)
                
            case let professorVC as ProfessorLanding:
                professorVC.modalPresentationStyle = .fullScreen
                self.present(professorVC,animated: true)
                
            case let studentVC as StudentLanding:
                studentVC.modalPresentationStyle = .fullScreen
                self.present(studentVC,animated: true)
                
            default:
                print("Class not created yet")
            }

        }) { error in
            AlertManager.showAlert(title: "Login Error", message: error.localizedDescription, target: self)
        }
//        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] (result, error) in
//            guard let self = self else { return }
//            guard error == nil else { AlertManager.showAlert(title: "Login Error", message: error!.localizedDescription, target: self) ; return}
//            //Determining the user's type and which landing to show
//            self.ref.observeSingleEvent(of: .value) { [weak self] (dataSnapShot) in
//                guard let self = self else { return }
//                if dataSnapShot.exists() == false {return}
//                for child in dataSnapShot.children{
//                    let user = (child as! DataSnapshot).value  as! [String: String]
//                    if user["user"] == self.emailTextField.text!{
//                        switch self.storyboard?.instantiateViewController(withIdentifier: "\(user["type"]!)Landing") {
//                        case let adminVC as AdminLanding:
//                            adminVC.modalPresentationStyle = .fullScreen
//                            self.present(adminVC,animated: true)
//
//                        case let professorVC as ProfessorLanding:
//                            professorVC.modalPresentationStyle = .fullScreen
//                            self.present(professorVC,animated: true)
//
//                        case let studentVC as StudentLanding:
//                            studentVC.modalPresentationStyle = .fullScreen
//                            self.present(studentVC,animated: true)
//
//                        default:
//                            print("Class not created yet")
//                        }
//                        break
//                    }
//                }
//            }
//        }
    }
}
