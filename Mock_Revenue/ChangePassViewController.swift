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

        configureNavigation()
        
        textFieldDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
        textFieldDelegate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDelegate() {
        self.txtConfirmPassword.delegate = self
        self.txtNewPassword.delegate = self
        self.txtCurrentPassword.delegate = self
    }
    
    func configureNavigation() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func btnChangeClick(_ sender: UIButton) {
        KRActivityIn.startActivityIndicator(uiView: self.view)
        
        if (txtNewPassword.text?.characters.count)! < 6 {
            let alertController = UIAlertController(title: "Error", message: "Passowrd has at least 6 characters", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            KRActivityIn.stopActivityIndicator()
        } else {
            if txtNewPassword.text != txtConfirmPassword.text {
                let alertController = UIAlertController(title: "Error", message: "Confirm new password is wrong", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                KRActivityIn.stopActivityIndicator()
            } else {
                daoUser.changePassword(currentPassword: txtCurrentPassword.text!, newPassword: txtNewPassword.text!, completionHandler: { (error) in
                    if error == nil {
                        let alertController = UIAlertController(title: "Success", message: "Change Password Success!!!", preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    KRActivityIn.stopActivityIndicator()
                })
            }
        }
    }
    
    @IBAction func btnMenuClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.viewControllers = [vc]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
