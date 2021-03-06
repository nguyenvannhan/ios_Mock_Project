//
//  LoginController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    

    @IBOutlet weak var txtEmail: ValidationTextField!
    @IBOutlet weak var txtPassword: ValidationTextField!
    
    let commonFunction: CommonFunction = CommonFunction()
    let daoUser: DAOUser = DAOUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        checkSaveLogin()
        
        textFieldDelegate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldDelegate() {
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
    }
    
    //Sự kiện click button Đăng nhập
    @IBAction func btnSignInClick(_ sender: UIButton) {
        //Load waiting icon
        KRActivityIn.startActivityIndicator(uiView: self.view)
        
        //Kiểm tra các textfield
        if  txtEmail.text == "" || txtPassword.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please complete information", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            KRActivityIn.stopActivityIndicator()
        } else if !commonFunction.isValidEmail(testStr: txtEmail.text!) { // Kiemer tra định dạng email
            let alertController = UIAlertController(title: "Error", message: "Email is not true!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            KRActivityIn.stopActivityIndicator()
        } else if (txtPassword.text?.characters.count)! < 6 { // Kiểm tra số Ký tự mật khẩu
            let alertController = UIAlertController(title: "Error", message: "Password must have at least 6 characters!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            KRActivityIn.stopActivityIndicator()
        } else {
            
            //Đăng nhập thông qua API của Firebase với email và password dã đăng ký
            daoUser.login(email: txtEmail.text!, password: txtPassword.text!, completionHandler: { (error) in
                if error != nil {
                    //Nếu lỗi thì hiện thông báo lỗi
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    KRActivityIn.stopActivityIndicator()
                } else {
                    KRActivityIn.stopActivityIndicator()
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    self.navigationController?.viewControllers = [viewController]
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            })
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
    
    //Kiểm tra thông tin Auto Login
    func checkSaveLogin() {
        if let username = UserDefaults.standard.string(forKey: "email"), let password = UserDefaults.standard.string(forKey: "password") {
            if username != "" && password != "" {
                KRActivityIn.startActivityIndicator(uiView: self.view)
                
                daoUser.login(email: username, password: password, completionHandler: { (error) in
                    if error != nil {
                        //Nếu lỗi thì hiện thông báo lỗi
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                        KRActivityIn.stopActivityIndicator()
                    } else {
                        KRActivityIn.stopActivityIndicator()
                        
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                        self.navigationController?.viewControllers = [viewController]
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                })
            }
            
        }
    }
}
