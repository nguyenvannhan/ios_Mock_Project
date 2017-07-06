//
//  CommonReportController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/16/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class CommonReportController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var reportCollectionView: UICollectionView!
    
    var reportList: [CommonReportModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let daoReport: DAOReport = DAOReport()
        
        self.reportCollectionView.delegate = self
        self.reportCollectionView.dataSource = self
        
        checkInternet()
        configureNavigation()
        
        KRActivityIn.startActivityIndicator(uiView: self.view)
        
        daoReport.getDataList(completionHandler: { (reportList, error) in
            if error == nil {
                self.reportList = reportList!
                DispatchQueue.main.async {
                    self.reportCollectionView.reloadData()
                    KRActivityIn.stopActivityIndicator()
                }
            } else {
                KRActivityIn.stopActivityIndicator()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let daoReport: DAOReport = DAOReport()
        
        self.reportCollectionView.delegate = self
        self.reportCollectionView.dataSource = self
        
        checkInternet()
        configureNavigation()
        
        daoReport.getDataList(completionHandler: { (reportList, error) in
            if error == nil {
                self.reportList = reportList!
                DispatchQueue.main.async {
                    self.reportCollectionView.reloadData()
                }
            }
        })
    }
    
    func configureNavigation() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reportList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reportModel = reportList[indexPath.row]
        
        let cell = self.reportCollectionView.dequeueReusableCell(withReuseIdentifier: "CommonReportCell", for: indexPath) as! CommonReportCell
        
        cell.configure(model: reportModel)
        
        return cell
    }
    
    @IBAction func btnMenuClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.indexTemp = 2
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
