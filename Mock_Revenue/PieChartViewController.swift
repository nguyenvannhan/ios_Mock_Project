//
//  PieChartViewController.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/6/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {

    @IBOutlet weak var pieOutComeView: PieChartView!
    @IBOutlet weak var pieIncomeView: PieChartView!
    @IBOutlet weak var lbName: UILabel!
    
    var commonReport: CommonReportModel?
    var idType: Int?
    
    let daoReport: DAOReport = DAOReport()
    
    var detailIncomeType: [ReportByCateModel] = []
    var detailOutcomeType: [ReportByCateModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        daoReport.getReportByCate(commonReport: commonReport!, idType: idType!, completionHandler: { (detailtIncome, detailOutcome) in
            DispatchQueue.main.async {
                self.detailIncomeType = detailtIncome
                self.detailOutcomeType = detailOutcome
                
                print("Income")
                for detail in self.detailIncomeType {
                    print(detail.percent)
                }
                print("OutCome")
                for detail in self.detailOutcomeType {
                    print(detail.percent)
                }
                
                self.setChart(detailIncomeReport: self.detailIncomeType, detailOutcomeReport: self.detailOutcomeType)
                self.pieIncomeView.notifyDataSetChanged()
                self.pieOutComeView.notifyDataSetChanged()
            }
        })
    }
    
    func setChart(detailIncomeReport: [ReportByCateModel], detailOutcomeReport: [ReportByCateModel]) {
        
        var dataIncomeEntries: [PieChartDataEntry] = []
        
        for i in 0..<detailIncomeReport.count {
            let detail = detailIncomeReport[i]
            let dataEntry = PieChartDataEntry(value: detail.percent, label: detail.nameType)
            dataIncomeEntries.append(dataEntry)
        }
        
        let pieChartIncomeDataSet = PieChartDataSet()
        pieChartIncomeDataSet.values = dataIncomeEntries
        let pieChartIncomeData = PieChartData(dataSet: pieChartIncomeDataSet)
        pieIncomeView.data = pieChartIncomeData
        
        var dataOutcomeEntries: [PieChartDataEntry] = []
        
        for i in 0..<detailOutcomeReport.count {
            let detail = detailOutcomeReport[i]
            let dataEntry = PieChartDataEntry(value: detail.percent, label: detail.nameType)
            dataOutcomeEntries.append(dataEntry)
        }
        
        let pieChartOutcomeDataSet = PieChartDataSet()
        pieChartOutcomeDataSet.values = dataOutcomeEntries
        let pieChartOutcomeData = PieChartData(dataSet: pieChartOutcomeDataSet)
        pieOutComeView.data = pieChartOutcomeData
        
        
        var colors: [UIColor] = []
        
        for _ in 0..<detailIncomeReport.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartIncomeDataSet.colors = colors
        
        colors = []
        
        for _ in 0..<detailOutcomeReport.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartOutcomeDataSet.colors = colors
        
    }

}
