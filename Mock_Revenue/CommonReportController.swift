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
        
        User.uid = "i6iRZSHqpEMeKsT0F3INlk3Qa9Z2"
        
        let daoReport: DAOReport = DAOReport()
        
        self.reportCollectionView.delegate = self
        self.reportCollectionView.dataSource = self
        
        User.uid = "i6iRZSHqpEMeKsT0F3INlk3Qa9Z2"
        
        daoReport.getDataList(completionHandler: { (reportList, error) in
            if error == nil {
                self.reportList = reportList!
                DispatchQueue.main.async {
                    self.reportCollectionView.reloadData()
                }
            }
        })
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
}
