//
//  RegisterPicker.swift
//  Examinator
//
//  Created by Mostafa Elshazly on 2/21/20.
//  Copyright © 2020 Mostafa Elshazly. All rights reserved.
//

import UIKit

class RegisterPicker:UIViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! Register).accType = segue.identifier!
    }
}
