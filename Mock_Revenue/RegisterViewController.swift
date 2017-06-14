//
//  RegisterViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtEmail: ValidationTextField!
    @IBOutlet weak var txtPassword: ValidationTextField!
    @IBOutlet weak var txtConfirmPass: ValidationTextField!
    
    var commonFunction: CommonFunction = CommonFunction()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Bắt sự kiên click button dăng ký
    @IBAction func btnRegistryClick(_ sender: UIButton) {
        //Kiểm tra các textfield có trống không
        if txtEmail.text == "" || txtPassword.text == "" || txtConfirmPass.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please complete information", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            //Đăng ký tài khoản sử dụng API của Firebase
            Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!, completion: { (user, error) in
                if error == nil {
                    //Nếu thành công chuyển qua trnag main
                    print("You have successfully sign up")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    //Nếu thất bại hiện thông báo lỗi
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    //Sự kiện click button Đăng nhập -> Chuyển qua trang đăng nhập
    @IBAction func btnSignInClick(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(vc!, animated: true, completion: nil)
    }
    
    //Validation textfield Email
    @IBAction func txtEmailDidEnd(_ sender: Any) {
        let txt = sender as? ValidationTextField
        let str = txt?.text
        
        if str?.characters.count == 0 {
            txt?.setError(error: true, message: "Please Enter info!")
        } else if !commonFunction.isValidEmail(testStr: str!) {
            txt?.setError(error: true, message: "Email is not true!")
        } else {
            txt?.setError(error: false, message: "")
        }
        
    }
    
    //Validation textfield password
    @IBAction func txtPasswordDidEnd(_ sender: Any) {
        let txt = sender as? ValidationTextField
        let str = txt?.text
        
        if str?.characters.count == 0 {
            txt?.setError(error: true, message: "Please enter password")
        } else if (str?.characters.count)! < 6 {
            txt?.setError(error: true, message: "Password must have 6 characters at least")
        } else {
            txt?.setError(error: false, message: "")
        }
    }
    
    //Validation textfield confirm
    @IBAction func txtConfirmDidEnd(_ sender: Any) {
        let txt = sender as? ValidationTextField
        let str = txt?.text
        
        if str?.characters.count == 0 {
            txt?.setError(error: true, message: "Please confirm password")
        } else if str != txtPassword.text {
            txt?.setError(error: true, message: "Password and confirm don't match")
        } else {
            txt?.setError(error: false, message: "")
        }
    }
}
