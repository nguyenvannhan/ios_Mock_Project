//
//  LoginController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var txtEmail: ValidationTextField!
    @IBOutlet weak var txtPassword: ValidationTextField!
    
    let commonFunction: CommonFunction = CommonFunction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Sự kiện click button Đăng nhập
    @IBAction func btnSignInClick(_ sender: UIButton) {
        //Kiểm tra các textfield
        if  txtEmail.text == "" || txtPassword.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please complete information", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            //Đăng nhập thông qua API của Firebase với email và password dã đăng ký
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
                if error != nil {
                    //Nếu lỗi thì hiện thông báo lỗi
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    //Thành công, chuyển sang trang main
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
    }
    
    //Validation textfield email
    @IBAction func txtEmailChange(_ sender: Any) {
        let txt = sender as? ValidationTextField
        let str: String = txt!.text!
        
        if str.characters.count == 0 {
            txt?.setError(error: true, message: "Please Enter info!")
        } else {
            if !commonFunction.isValidEmail(testStr: str) {
                txt?.setError(error: true, message: "Email is not true!")
            } else {
                txt?.setError(error: false, message: "")
            }
        }
    }
    
    //Validation textfield password
    @IBAction func txtPasswordChange(_ sender: Any) {
        let txt = sender as? ValidationTextField
        let str: String = txt!.text!
        
        if str.characters.count == 0 {
            txt?.setError(error: true, message: "Please Enter info!")
        } else {
            if str.characters.count < 6 {
                txt?.setError(error: true, message: "Password must have 6 characters at least!")
            } else {
                txt?.setError(error: false, message: "")
            }
        }
    }

}
