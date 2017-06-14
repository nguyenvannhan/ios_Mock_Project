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
            let revenueType: RevenueType = RevenueType(name: txtNameRevenueType.text, image: imageTemp)
            var loaichi: Bool = true
            
            if sgmRevenueType.selectedSegmentIndex == 1 {
                loaichi = false
            }
            
            daoRevenueType.addNewRevenueType(loaiChi: loaichi, revenueType: revenueType, completionHandler: { (error) in
                if (error != nil) {
                    let alertController = UIAlertController(title: "Error", message: "Add New Revenue Type Fail!", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Add New Revenue Type Success!", preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func txtNameEditingEnd(_ sender: Any) {
        if txtNameRevenueType.text == "" {
            txtNameRevenueType.setError(error: true, message: "Please Enter Revenue Type Name")
        }
    }
}
