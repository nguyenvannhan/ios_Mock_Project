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
    @IBOutlet weak var txtAmount: ValidationTextField!
    @IBOutlet weak var txtAge: ValidationTextField!
    @IBOutlet weak var txtName: ValidationTextField!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    var commonFunction: CommonFunction = CommonFunction()
    var daoUser: DAOUser = DAOUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFiledDelegate()
        configureScrollView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFiledDelegate() {
        self.txtEmail.delegate = self
        self.txtPassword.delegate = self
        self.txtConfirmPass.delegate = self
        self.txtAmount.delegate = self
        self.txtAge.delegate = self
        self.txtName.delegate = self
        
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(self.userTappedBackground))
        self.myScrollView.addGestureRecognizer(tapEvent)
    }
    
    func configureScrollView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //Bắt sự kiên click button dăng ký
    @IBAction func btnRegistryClick(_ sender: UIButton) {
        KRActivityIn.startActivityIndicator(uiView: self.view)
        var textAmount: String = ""
        if let text = txtAmount.text {
            textAmount = commonFunction.removeDotText(text: text)
        }
        
        //Kiểm tra các textfield có trống không
        if txtEmail.text == "" || txtPassword.text == "" || txtConfirmPass.text == "" || txtName.text == "" || txtAmount.text == "" || textAmount == "0" {
            let alertController = UIAlertController(title: "Error", message: "Please complete information", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            KRActivityIn.stopActivityIndicator()
        } else if !commonFunction.isValidEmail(testStr: txtEmail.text!) {
            let alertController = UIAlertController(title: "Error", message: "Email is not true!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            KRActivityIn.stopActivityIndicator()
        } else if (txtPassword.text?.characters.count)! < 6 {
            let alertController = UIAlertController(title: "Error", message: "Passwrod must have at least 6 characters!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            KRActivityIn.stopActivityIndicator()
        } else if txtPassword.text != txtConfirmPass.text {
            let alertController = UIAlertController(title: "Error", message: "Please confirm password again!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
            KRActivityIn.stopActivityIndicator()
        } else {
            
            //Đăng ký tài khoản sử dụng API của Firebase
            daoUser.registry(email: txtEmail.text!, password: txtPassword.text!, name: txtName.text!, age: Int(txtAge.text!)!, amount: Double(textAmount)!, completionHandler: { (error) in
                if error == nil {
                    KRActivityIn.stopActivityIndicator()
                    
                    //Nếu thành công chuyển qua trnag main
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                    self.navigationController?.viewControllers = [viewController]
                    self.navigationController?.pushViewController(viewController, animated: true)
                    
                } else {
                    //Nếu thất bại hiện thông báo lỗi
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    KRActivityIn.stopActivityIndicator()
                }
            })
        }
    }
    
    //Sự kiện click button Đăng nhập -> Chuyển qua trang đăng nhập
    @IBAction func btnSignInClick(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
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
    
    @IBAction func amountValueChange(_ sender: Any) {
        if let text = txtAmount.text {
            let resultText = commonFunction.addDotText(text: text)
            txtAmount.text = resultText
            
            if text.characters.count == 0 {
                txtAmount.text = "0"
            }
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}
