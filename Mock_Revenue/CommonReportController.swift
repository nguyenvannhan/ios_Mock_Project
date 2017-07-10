//
//  CommonReportController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/16/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class CommonReportController: UIViewController {
    
    
    @IBOutlet weak var reportCollectionView: UICollectionView!
    
    var commonFunction: CommonFunction = CommonFunction()
    var reportList: [CommonReportModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reportCollectionView.delegate = self
        self.reportCollectionView.dataSource = self
        
        checkInternet()
        configureNavigation()
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        self.reportCollectionView.delegate = self
        self.reportCollectionView.dataSource = self
        
        checkInternet()
        configureNavigation()
        
        getData()
    }
    
    func configureNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenuClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.indexTemp = 2
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PieChart" {
            let vc = segue.destination as! PieChartViewController
            let cell = sender as! CommonReportCell
            let indexPath = self.reportCollectionView.indexPath(for: cell)
            let commonReport = self.reportList[(indexPath?.row)!]
            
            vc.commonReport = commonReport
            vc.idType = indexPath?.row
        }
    }
}
