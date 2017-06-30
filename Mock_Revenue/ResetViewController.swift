//
//  ResetViewController.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 6/30/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {
    
    var daoUser: DAOUser = DAOUser()
    var commonFunction: CommonFunction = CommonFunction()
    
    @IBOutlet weak var txtReset: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnResetClick(_ sender: Any) {
        if txtReset.text?.characters.count == 0 {
            let alertController = UIAlertController(title: "Error", message: "Please enter email!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else if !commonFunction.isValidEmail(testStr: txtReset.text!) {
            let alertController = UIAlertController(title: "Error", message: "Email format is wrong!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            KRActivityIn.startActivityIndicator(uiView: self.view)
            
            daoUser.resetPassword(email: txtReset.text!, completionHandler: { (error) in
                if error == nil {
                    KRActivityIn.stopActivityIndicator()
                    
                    let alertController = UIAlertController(title: "Error", message: "A reset email was send to your email. Please check your email!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    KRActivityIn.stopActivityIndicator()
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    

    @IBAction func btnCancell(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
