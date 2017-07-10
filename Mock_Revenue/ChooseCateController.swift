//
//  ChooseCateController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class ChooseCateController: UIViewController {

    @IBOutlet weak var sgmCateType: UISegmentedControl!
    @IBOutlet weak var tblCateList: UITableView!
    
    let daoRevenueType: DAORevenueType = DAORevenueType()
    let commonFunction: CommonFunction = CommonFunction()
    
    var revenueTypeList: [RevenueType] = []
    var isOutcome = true
    var myDelegate: SetValuePreviousVC?
    var isEdit: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblCateList.delegate = self
        self.tblCateList.dataSource = self
        
        if isEdit {
            if isOutcome {
                sgmCateType.setEnabled(true, forSegmentAt: 0)
                sgmCateType.setEnabled(false, forSegmentAt: 1)
                sgmCateType.selectedSegmentIndex = 0
            } else {
                sgmCateType.setEnabled(false, forSegmentAt: 0)
                sgmCateType.setEnabled(true, forSegmentAt: 1)
                sgmCateType.selectedSegmentIndex = 1
            }
        }
        
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sgmTypeChange(_ sender: Any) {
        self.revenueTypeList = []
        self.tblCateList.reloadData()
        if sgmCateType.selectedSegmentIndex == 0 {
            isOutcome = true
        } else {
            isOutcome = false
        }
        
        getData()
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
}
