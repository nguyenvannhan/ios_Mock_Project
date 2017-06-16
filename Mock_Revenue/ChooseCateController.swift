//
//  ChooseCateController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

protocol SetValuePreviousVC {
    func returnData(idType: Int?, revenueType: RevenueType?)
}

class ChooseCateController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sgmCateType: UISegmentedControl!
    @IBOutlet weak var tblCateList: UITableView!
    
    let daoRevenueType: DAORevenueType = DAORevenueType()
    var revenueTypeList: [RevenueType] = []
    var isOutcome = true
    var myDelegate: SetValuePreviousVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblCateList.delegate = self
        self.tblCateList.dataSource = self
        
        User.uid = "i6iRZSHqpEMeKsT0F3INlk3Qa9Z2"
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revenueTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblCateList.dequeueReusableCell(withIdentifier: "ChooseCateCell") as! ChooseCateCell
        let revenueType = revenueTypeList[indexPath.row]
        
        cell.configure(revenueType: revenueType)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revenueType = revenueTypeList[indexPath.row] as RevenueType
        var idType = 0
        
        if !isOutcome {
            idType = 1
        }
        
        myDelegate?.returnData(idType: idType, revenueType: revenueType)
        
        _ = navigationController?.popViewController(animated: true)
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
    
    func getData() {
        if isOutcome {
            daoRevenueType.getOutComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        self.tblCateList.reloadData()
                    }
                }
            })
        } else {
            daoRevenueType.getInComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        self.tblCateList.reloadData()
                    }
                }
            })
        }
    }
}
