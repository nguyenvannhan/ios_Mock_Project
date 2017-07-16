//
//  AddTransactionController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class AddTransactionController: UIViewController, SetValuePreviousVC {
    
    @IBOutlet weak var dtpDate: UIDatePicker!
    
    @IBOutlet weak var imgCate: UIImageView!
    @IBOutlet weak var lbNameCate: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    let commonFunction: CommonFunction = CommonFunction()
    let daoTransaction: DAOTransactionList = DAOTransactionList()

    var revenueTypeTemp: RevenueType = RevenueType(name: "Please choose Revenue Type!", image: "cate_default.png")
    var idType: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lbNameCate.text = revenueTypeTemp.name
        self.imgCate.image = UIImage(named: revenueTypeTemp.image!)
        
        txtNote.layer.borderWidth = 0.3
        txtNote.layer.borderColor = UIColor.gray.cgColor
        
        txtAmount.text = "0"
        
        textFieldDelegate()
        configureScrollView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.idType != nil {
            self.lbNameCate.text = revenueTypeTemp.name
            self.imgCate.image = UIImage(named: revenueTypeTemp.image!)
            
            if idType != 0	 {
                self.txtAmount.textColor = UIColor.green
            } else {
                self.txtAmount.textColor = UIColor.red
            }
        }
        
        textFieldDelegate()
        configureScrollView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDelegate() {
        self.txtAmount.delegate = self
        self.txtNote.delegate = self
        
        let tapEvent = UITapGestureRecognizer(target: self, action: #selector(self.userTappedBackground))
        self.myScrollView.addGestureRecognizer(tapEvent)
    }
    
    func configureScrollView() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func btnChangeCateClick(_ sender: UIButton) {
        let chooseCateVC = self.storyboard?.instantiateViewController(withIdentifier: "ChooseCateController") as! ChooseCateController
        
        // 2. Set self as a value to delegate
        chooseCateVC.myDelegate = self
        chooseCateVC.isEdit = false
        
        // 3. Push SecondViewController
        self.navigationController?.pushViewController(chooseCateVC, animated: true)
    }

    @IBAction func btnSaveClick(_ sender: UIButton) {
        KRActivityIn.startActivityIndicator(uiView: self.view)
        
        var amountText: String = ""
        if let text = txtAmount.text {
            amountText = commonFunction.removeDotText(text: text)
        }
        
        if lbNameCate.text == "Please choose Revenue Type!" {
            let alertController = UIAlertController(title: "Error", message: "Please choose a Revenue Type!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            KRActivityIn.stopActivityIndicator()
        } else {
            checkInternet()
            
            if amountText == "0" {
                let alertController = UIAlertController(title: "Error", message: "Please enter amount!", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                KRActivityIn.stopActivityIndicator()
            } else {
                
                let dateFomatter = DateFormatter()
                dateFomatter.dateFormat = "dd/MM/yyyy"
                let date = dateFomatter.string(from: dtpDate.date)
                
                let transactionModel = TransactionModel(imageType: revenueTypeTemp.image, nameType: revenueTypeTemp.name, idType: idType, note: txtNote.text, amount: Double(amountText), date: date)
                
                daoTransaction.addNewTransaction(transactionModel: transactionModel, completionHandler: { (error) in
                    
                    if error == nil {
                        KRActivityIn.stopActivityIndicator()
                        _ = self.navigationController?.popViewController(animated: true)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        KRActivityIn.stopActivityIndicator()
                    }
                })
            }
        }
    }
    
    @IBAction func txtAmountEditChange(_ sender: Any) {
        if let text = txtAmount.text {
            let resultText = commonFunction.addDotText(text: text)
            txtAmount.text = resultText
            
            if text.characters.count == 0 {
                txtAmount.text = "0"
            }
        }
    }
    
    func returnData(idType: Int?, revenueType: RevenueType?) {
        if revenueType != nil {
            self.revenueTypeTemp = revenueType!
            self.idType = idType
        }
    }
    
    func checkInternet() {
        let flag: Bool = commonFunction.checkInternet()
        
        if !flag {
            let alertController = UIAlertController(title: "No Internet Available", message: "Please check your connection and press Reload!", preferredStyle: .alert)
            
            
            let defaultAction = UIAlertAction(title: "Reload", style: .default, handler: { (action: UIAlertAction) in
                self.checkInternet()
            })
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}
