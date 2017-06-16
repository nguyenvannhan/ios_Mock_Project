//
//  ChangePassViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/16/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChangePassViewController: UIViewController {

    @IBOutlet weak var txtConfirmPassword: ValidationTextField!
    @IBOutlet weak var txtNewPassword: ValidationTextField!
    @IBOutlet weak var txtCurrentPassword: ValidationTextField!
    
    let daoUser = DAOUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnChangeClick(_ sender: UIButton) {
        if (txtNewPassword.text?.characters.count)! < 6 {
            let alertController = UIAlertController(title: "Error", message: "Passowrd has at leat 6 characters", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
        } else {
            if txtNewPassword.text != txtConfirmPassword.text {
                let alertController = UIAlertController(title: "Error", message: "Confirm new password is wrong", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
            } else {
                daoUser.changePassword(currentPassword: txtCurrentPassword.text!, newPassword: txtNewPassword.text!, completionHandler: { (error) in
                    if error == nil {
                        let alertController = UIAlertController(title: "Success", message: "Chane Password Success!!!", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                    }
                })
            }
        }
    }
    
}
