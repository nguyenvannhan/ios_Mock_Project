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

    @IBOutlet weak var pieChartView: PieChartView!
    
    var commonReport: CommonReportModel?
    var idType: Int?
    
    let daoReport: DAOReport = DAOReport()
    
    var detailIncomeType: [ReportByCateModel] = []
    var detailOutcomeType: [ReportByCateModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold = [20.0, 10.0, 15.0, 15.0, 20.0, 20.0]
        
        setChart(dataPoints: months, values: unitsSold)
        pieChartView.notifyDataSetChanged()
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
                
                print(self.detailIncomeType)
                print(self.detailOutcomeType)
            }
        })
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet()
        pieChartDataSet.values = dataEntries
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
    }

}
