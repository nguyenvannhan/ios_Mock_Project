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
                
                self.setChart(detailIncomeReport: self.detailIncomeType, detailOutcomeReport: self.detailOutcomeType)
                self.pieIncomeView.notifyDataSetChanged()
                self.pieOutComeView.notifyDataSetChanged()
            }
        })
    }
    
    func setChart(detailIncomeReport: [ReportByCateModel], detailOutcomeReport: [ReportByCateModel]) {
        let tempColors: [UIColor] = [UIColor.red, UIColor.green, UIColor.blue, UIColor.brown, UIColor.lightGray]
        var colors: [UIColor] = []
        
        if detailIncomeReport.count > 0 {
            var dataIncomeEntries: [PieChartDataEntry] = []
            
            for i in 0..<detailIncomeReport.count {
                let detail = detailIncomeReport[i]
                let dataEntry = PieChartDataEntry(value: detail.percent, label: detail.nameType)
                dataIncomeEntries.append(dataEntry)
            }
            
            let pieChartIncomeDataSet = PieChartDataSet(values: dataIncomeEntries, label: "")
            let pieChartIncomeData = PieChartData(dataSet: pieChartIncomeDataSet)
            pieIncomeView.data = pieChartIncomeData
            
            for i in 0..<detailIncomeReport.count {
                let color = tempColors[i]
                colors.append(color)
            }
            pieChartIncomeDataSet.colors = colors
        }
        pieIncomeView.chartDescription?.text = ""
        pieIncomeView.noDataText = "No Data Transation"

        if detailOutcomeReport.count > 0 {
            var dataOutcomeEntries: [PieChartDataEntry] = []
            
            for i in 0..<detailOutcomeReport.count {
                let detail = detailOutcomeReport[i]
                let dataEntry = PieChartDataEntry(value: detail.percent, label: detail.nameType)
                dataOutcomeEntries.append(dataEntry)
            }
            
            let pieChartOutcomeDataSet = PieChartDataSet(values: dataOutcomeEntries, label: "")
            let pieChartOutcomeData = PieChartData(dataSet: pieChartOutcomeDataSet)
            pieOutComeView.data = pieChartOutcomeData
            
            colors = []
            
            for i in 0..<detailOutcomeReport.count {
                let color = tempColors[i]
                colors.append(color)
            }
            
            pieChartOutcomeDataSet.colors = colors
        }
        pieOutComeView.chartDescription?.text = ""
        pieOutComeView.noDataText = "No Data Transaction"
        
    }

}
