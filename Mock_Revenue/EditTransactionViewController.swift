//
//  EditTransactionViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/16/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class EditTransactionViewController: UIViewController, SetValuePreviousVC {

    @IBOutlet weak var dtpDate: UIDatePicker!
    
    @IBOutlet weak var imgCate: UIImageView!
    @IBOutlet weak var lbNameCate: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var myScrollView: UIScrollView!
    
    let daoTransaction: DAOTransactionList = DAOTransactionList()
    let commonFunction: CommonFunction = CommonFunction()
    
    var revenueTypeTemp: RevenueType = RevenueType(name: "Please choose Revenue Type!", image: "cate_default.png")
    var transactionModel: TransactionModel?
    var idType: Int?
    var currentAmount: Double = 0
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        revenueTypeTemp.name = transactionModel?.nameType
        revenueTypeTemp.image = transactionModel?.imageType
        self.lbNameCate.text = revenueTypeTemp.name
        self.imgCate.image = UIImage(named: revenueTypeTemp.image!)
        self.txtAmount.text = commonFunction.addDotText(text: String(format: "%.0f", (transactionModel?.amount)!))
        self.txtNote.text = transactionModel?.note
        self.idType = transactionModel?.idType
        self.currentAmount = (transactionModel?.amount)!
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dtpDate.date = dateFormatter.date(from: (transactionModel?.date)!)!
        
        txtNote.layer.borderWidth = 0.3
        txtNote.layer.borderColor = UIColor.gray.cgColor
        
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
        chooseCateVC.isEdit = true
        if transactionModel?.idType == 0 {
            chooseCateVC.isOutcome = true
        } else {
            chooseCateVC.isOutcome = false
        }
        
        // 3. Push SecondViewController
        self.navigationController?.pushViewController(chooseCateVC, animated: true)
    }
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        if lbNameCate.text == "Please choose Revenue Type!" {
            let alertController = UIAlertController(title: "Error", message: "Please choose a Revenue Type!", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            checkInternet()
            
            var amountText: String = ""
            if let text = txtAmount.text {
                amountText = commonFunction.removeDotText(text: text)
            }
            
            if amountText == "0" {
                let alertController = UIAlertController(title: "Error", message: "Please enter amount!", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                KRActivityIn.startActivityIndicator(uiView: self.view)
                
                let dateFomatter = DateFormatter()
                dateFomatter.dateFormat = "dd/MM/yyyy"
                let date = dateFomatter.string(from: dtpDate.date)
                
                let transactionModelc = TransactionModel(imageType: revenueTypeTemp.image, nameType: revenueTypeTemp.name, idType: idType, note: txtNote.text, amount: Double(amountText), date: date)
                transactionModelc.key = transactionModel?.key
                
                daoTransaction.editTransaction(currentAmount: currentAmount, transactionModel: transactionModelc, completionHandler: { (error) in
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
