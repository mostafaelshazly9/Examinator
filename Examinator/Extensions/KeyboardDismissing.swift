//
//  KeyboardDismissing.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 8/4/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
