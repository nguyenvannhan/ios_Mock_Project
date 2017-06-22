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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnChangeCateClick(_ sender: UIButton) {
        let chooseCateVC = self.storyboard?.instantiateViewController(withIdentifier: "ChooseCateController") as! ChooseCateController
        
        // 2. Set self as a value to delegate
        chooseCateVC.myDelegate = self
        
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
            if txtAmount.text == "0" || txtAmount.text == "" {
                let alertController = UIAlertController(title: "Error", message: "Please enter amount!", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                let dateFomatter = DateFormatter()
                dateFomatter.dateFormat = "dd/MM/yyyy"
                let date = dateFomatter.string(from: dtpDate.date)
                
                let transactionModel = TransactionModel(imageType: revenueTypeTemp.image, nameType: revenueTypeTemp.name, idType: idType, note: txtNote.text, amount: Double(txtAmount.text!), date: date)
                
                daoTransaction.addNewTransaction(transactionModel: transactionModel, completionHandler: { (error) in
                    
                    if error == nil {
                        _ = self.navigationController?.popViewController(animated: true)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                    }
                })
            }
        }
    }
    
    func returnData(idType: Int?, revenueType: RevenueType?) {
        if revenueType != nil {
            self.revenueTypeTemp = revenueType!
            self.idType = idType
        }
    }
}
