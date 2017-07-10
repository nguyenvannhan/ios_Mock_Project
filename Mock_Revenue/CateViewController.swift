//
//  CateViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class CateViewController: UIViewController {
    
    @IBOutlet weak var tblCateList: UITableView!
    @IBOutlet weak var sgmTypeCate: UISegmentedControl!
    
    var commonFunction: CommonFunction = CommonFunction()
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
    
    @IBAction func btnMenuClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.indexTemp = 1
        self.navigationController?.pushViewController(vc, animated: true)
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
