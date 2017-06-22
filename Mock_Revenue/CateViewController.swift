//
//  CateViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class CateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblCateList: UITableView!
    @IBOutlet weak var sgmTypeCate: UISegmentedControl!
    
    var revenueTypeList: [RevenueType] = []
    var isOutcome = true
    
    let daoRevenueType: DAORevenueType = DAORevenueType()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblCateList.delegate = self
        self.tblCateList.dataSource = self
        
        checkInternet()
        configureNavigation()
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkInternet()
        configureNavigation()
        
        getData()
    }
    
    func configureNavigation() {
        self.navigationItem.title = "Revenue Type List"
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revenueTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let revenueType = revenueTypeList[indexPath.row]
        
        let cell = tblCateList.dequeueReusableCell(withIdentifier: "CateViewCell") as! CateViewCell
        
        cell.configure(typeRevenue: revenueType)
        
        return cell
    }
    
    @IBAction func sgmChange(_ sender: Any) {
        self.revenueTypeList = []
        self.tblCateList.reloadData()
        if sgmTypeCate.selectedSegmentIndex == 0 {
            isOutcome = true
        } else {
            isOutcome = false
        }
        
        getData()
    }
    
    func getData() {
        KRActivityIn.startActivityIndicator(uiView: self.view)
        if isOutcome {
            daoRevenueType.getOutComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = []
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        KRActivityIn.stopActivityIndicator()
                        self.tblCateList.reloadData()
                    }
                }
            })
        } else {
            daoRevenueType.getInComeType(completionHandler: { (revenueTypeList, error) in
                if error == nil {
                    self.revenueTypeList = []
                    self.revenueTypeList = revenueTypeList!
                    
                    DispatchQueue.main.async {
                        KRActivityIn.stopActivityIndicator()
                        self.tblCateList.reloadData()
                    }
                }
            })
        }
    }
    
    @IBAction func btnMenuClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.indexTemp = 1
        self.navigationController?.pushViewController(vc, animated: true)
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
