//
//  AddNewCateController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class AddNewCateController: UIViewController, SendImageBack {

    @IBOutlet weak var imgRevenueType: UIImageView!
    @IBOutlet weak var txtNameRevenueType: ValidationTextField!
    @IBOutlet weak var sgmRevenueType: UISegmentedControl!
    
    var imageTemp: String =  "cate_default.png"
    
    let daoRevenueType: DAORevenueType = DAORevenueType()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if imgRevenueType.image != UIImage(named:imageTemp) {
            imgRevenueType.image = UIImage(named: imageTemp)
        }
    }
    
    func setValueImage(image: String) {
        self.imageTemp = image
    }

    @IBAction func btnChangeClick(_ sender: Any) {
        let chooseImageVC = self.storyboard?.instantiateViewController(withIdentifier: "ImageCateController") as! ImageCateController
        
        // 2. Set self as a value to delegate
        chooseImageVC.myDelegate = self
        
        // 3. Push SecondViewController
        self.navigationController?.pushViewController(chooseImageVC, animated: true)
    }
    
    @IBAction func btnSaveCick(_ sender: UIButton) {
        if txtNameRevenueType.text == "" {
            txtNameRevenueType.setError(error: true, message: "Please Enter Revenue Type Name")
        } else {
            checkInternet()
            
            let revenueType: RevenueType = RevenueType(name: txtNameRevenueType.text, image: imageTemp)
            var loaichi: Bool = true
            
            if sgmRevenueType.selectedSegmentIndex == 1 {
                loaichi = false
            }
            
            KRActivityIn.startActivityIndicator(uiView: self.view)
            
            daoRevenueType.addNewRevenueType(loaiChi: loaichi, revenueType: revenueType, completionHandler: { (error) in
                if (error != nil) {
                    let alertController = UIAlertController(title: "Error", message: "Add New Revenue Type Fail!", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    KRActivityIn.stopActivityIndicator()
                } else {
                    let alertController = UIAlertController(title: "Success", message: "Add New Revenue Type Success!", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                    KRActivityIn.stopActivityIndicator()
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
    }
    
    @IBAction func txtNameEditingEnd(_ sender: Any) {
        let txt = sender as? ValidationTextField
        let str = txt?.text
        
        if str?.characters.count == 0 {
            txt?.setError(error: true, message: "Please Enter Revenue Type Name")
        }
    }
    
    func checkInternet() {
        var flag: Bool = false
        
        var times = 0
        
        while !flag {
            
            let status = DAOInternet().connectionStatus()
            switch status {
            case .unknown, .offline:
                flag = false
                break
            case .online(.wwan):
                flag = true
                break
            case .online(.wiFi):
                flag = true
                break
            }
            
            times += 1
            
            if (times == 50) {
                break
            }
        }
        
        if !flag {
            let alertController = UIAlertController(title: "No Internet Available", message: "Please check your connection and press Reload!", preferredStyle: .alert)
            
            
            let defaultAction = UIAlertAction(title: "Reload", style: .default, handler: { (action: UIAlertAction) in
                self.checkInternet()
            })
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
