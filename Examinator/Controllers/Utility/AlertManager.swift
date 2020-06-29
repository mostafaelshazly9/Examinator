//
//  AlertManager.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/21/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//


import UIKit

class AlertManager: NSObject {
    class func showAlert(title:String?, message:String?, target:UIViewController, completion: (() -> Void)? = nil){
        let alert = UIAlertController(title: title ?? "Notification",
                                      message: message ?? "Unkown",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        target.present(alert, animated: true, completion: completion)
    }
    
    class func showAlertWithTextFields(title:String?, message:String?, textFieldPlaceHolders:[String], target:UIViewController, completion: ((_:[UITextField]) -> Void)?){
        let alert = UIAlertController(title: title ?? "Notification",
                                      message: message ?? "Unkown",
                                      preferredStyle: .alert)
        for placeHolder in textFieldPlaceHolders{
            alert.addTextField {
                $0.placeholder = placeHolder
            }
        }
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            guard completion != nil else { return }
            completion!(alert.textFields ?? [])
        }))
        
        target.present(alert, animated: true)
    }
    
    
}

