//
//  DAOReport.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/16/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation

class DAOReport {
    var daoCate: DAORevenueType = DAORevenueType()
    var daoTransaction: DAOTransactionList = DAOTransactionList()
    
    var transactionList:  [TransactionModel] = []
    var incomeTypeList: [RevenueType] = []
    var expenseTypeList: [RevenueType] = []
    
    let dateFomatter = DateFormatter()
    let currentDate = Date()
    
    func getReportToday(completionHandler: @escaping (_ reportModel: CommonReportModel?, _ error: String?) -> Void) {
        dateFomatter.dateFormat = "dd/MM/yyyy"
        let date = "Today (" + dateFomatter.string(from: currentDate) + ")"
        
        var totalExpense: Double = 0
        var totalIncome: Double = 0
        var totalBalance: Double = 0
        
        daoTransaction.getTransactionList(completionHandler: { (transactionList, error) in
            if error == nil {
                self.transactionList = transactionList!
                for transaction in self.transactionList {
                    if transaction.date == self.dateFomatter.string(from: self.currentDate) {
                        if transaction.idType == 0 {
                            totalExpense += transaction.amount!
                            totalBalance -= transaction.amount!
                        } else {
                            totalIncome += transaction.amount!
                            totalBalance += transaction.amount!
                        }
                    }
                }
                
                let totalEx = String(format: "%g", totalExpense)
                let totalIn = String(format: "%g", totalIncome)
                let totalBal = String(format: "%g", totalBalance)
                
                completionHandler(CommonReportModel(name: date, totalIncome: totalIn, totalExpense: totalEx, totalBalance: totalBal), nil)
            } else {
                completionHandler(nil, error)
            }
            
        })
    }
    
    func getReportWeek(completionHandler: @escaping (_ reportModel: CommonReportModel?, _ error: String?) -> Void) {
        dateFomatter.dateFormat = "dd/MM/yyyy"
        let sunday = dateFomatter.string(from: getDayOfCurrentWeek(weekDay: 1))
        let saturday = dateFomatter.string(from: getDayOfCurrentWeek(weekDay: 7))
        
        let date = "This Week (" + sunday + " - " + saturday + ")"
        
        var totalExpense: Double = 0
        var totalIncome: Double = 0
        var totalBalance: Double = 0
        
        daoTransaction.getTransactionList(completionHandler: { (transactionList, error) in
            if error == nil {
                self.transactionList = transactionList!
                for transaction in self.transactionList {
                    if transaction.date! >= sunday && transaction.date! <= saturday {
                        if transaction.idType == 0 {
                            totalExpense += transaction.amount!
                            totalBalance -= transaction.amount!
                        } else {
                            totalIncome += transaction.amount!
                            totalBalance += transaction.amount!
                        }
                    }
                }
                
                let totalEx = String(format: "%g", totalExpense)
                let totalIn = String(format: "%g", totalIncome)
                let totalBal = String(format: "%g", totalBalance)
                
                completionHandler(CommonReportModel(name: date, totalIncome: totalIn, totalExpense: totalEx, totalBalance: totalBal), nil)
            } else {
                completionHandler(nil, error)
            }
            
        })
    }
    
    func getReportMoth(completionHandler: @escaping (_ reportModel: CommonReportModel?, _ error: String?) -> Void) {
        dateFomatter.dateFormat = "dd/MM/yyyy"
        let firstDate = getFirstDateOfMonth()
        let lastDate = getLastDateOfMont()
        
        let date = "This Month (" + firstDate + " - " + lastDate + ")"
        
        var totalExpense: Double = 0
        var totalIncome: Double = 0
        var totalBalance: Double = 0
        
        daoTransaction.getTransactionList(completionHandler: { (transactionList, error) in
            if error == nil {
                self.transactionList = transactionList!
                for transaction in self.transactionList {
                    if transaction.date! >= firstDate && transaction.date! <= lastDate {
                        if transaction.idType == 0 {
                            totalExpense += transaction.amount!
                            totalBalance -= transaction.amount!
                        } else {
                            totalIncome += transaction.amount!
                            totalBalance += transaction.amount!
                        }
                    }
                }
                
                let totalEx = String(format: "%g", totalExpense)
                let totalIn = String(format: "%g", totalIncome)
                let totalBal = String(format: "%g", totalBalance)
                
                completionHandler(CommonReportModel(name: date, totalIncome: totalIn, totalExpense: totalEx, totalBalance: totalBal), nil)
            } else {
                completionHandler(nil, error)
            }
            
        })
    }
    
    func getDataList(completionHandler: @escaping (_ reportList: [CommonReportModel]?, _ error: String?) -> Void) {
        var reportList: [CommonReportModel] = []
        
        getReportToday(completionHandler: { (reportModel, error) in
            if error == nil {
                reportList.append(reportModel!)
                self.getReportWeek(completionHandler: { (reportModelWeek, errorWeek) in
                    if errorWeek == nil {
                        reportList.append(reportModelWeek!)
                        self.getReportMoth(completionHandler: { (reportModelMonth, errorMonth) in
                            if errorMonth == nil {
                                reportList.append(reportModelMonth!)
                                completionHandler(reportList, nil)
                            }
                        })
                        completionHandler(reportList, nil)
                    }
                })
                completionHandler(reportList, nil)
            }
        })
    }
    
    func getReportByCate(commonReport: CommonReportModel, idType: Int, completionHandler: @escaping (_ detailIncomeReport: [ReportByCateModel], _ detailOutcomeReport: [ReportByCateModel]) -> Void) {
        dateFomatter.dateFormat = "dd/MM/yyyy"
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        daoTransaction.getTransactionList(completionHandler: { (transactionList, error) in
            if error == nil {
                self.transactionList = transactionList!
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        daoCate.getInComeType(completionHandler: { (incomeTypeList, error) in
            if error == nil {
                self.incomeTypeList = incomeTypeList!
            }
             dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        daoCate.getOutComeType(completionHandler: { (outcomeTypeList, error) in
            if error == nil {
                self.expenseTypeList = outcomeTypeList!
            }
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: DispatchQueue.global(qos: .background), execute: { () -> Void in
            var detailIncomeReport: [ReportByCateModel] = []
            var detailOutcomeReport: [ReportByCateModel] = []
            
            if idType == 0 {
                 let date = self.dateFomatter.string(from: self.currentDate)
                
                for incomeType in self.incomeTypeList {
                    var tong: Double = 0
                    
                    for transaction in self.transactionList {
                        if transaction.idType == 1 && transaction.date == date && transaction.nameType == incomeType.name {
                            tong += transaction.amount!
                        }
                    }
                    
                    let detailReport: ReportByCateModel = ReportByCateModel(nameType: incomeType.name!, percent: (tong / Double(commonReport.totalIncome!)!) * 100)
                    detailIncomeReport.append(detailReport)
                }
                
                for outcomeType in self.expenseTypeList {
                    var tong: Double = 0
                    
                    for transaction in self.transactionList {
                        if transaction.idType == 0 && transaction.date == date && transaction.nameType == outcomeType.name {
                            tong += transaction.amount!
                        }
                    }
                    
                    let detailReport: ReportByCateModel = ReportByCateModel(nameType: outcomeType.name!, percent: (tong / Double(commonReport.totalIncome!)!) * 100)
                    detailOutcomeReport.append(detailReport)
                }
            } else {
                var fromDate: String = String()
                var
                toDate: String = String()
                
                if idType == 1 {
                    fromDate = self.dateFomatter.string(from: self.getDayOfCurrentWeek(weekDay: 0))
                    toDate = self.dateFomatter.string(from: self.getDayOfCurrentWeek(weekDay: 1))
                } else {
                    fromDate = self.getFirstDateOfMonth()
                    toDate = self.getLastDateOfMont()
                }
                
                for incomeType in self.incomeTypeList {
                    var tong: Double = 0
                    
                    for transaction in self.transactionList {
                        if transaction.idType! == 1 && transaction.date! >= fromDate && transaction.date! <= toDate && transaction.nameType! == incomeType.name! {
                            tong += transaction.amount!
                        }
                    }
                    
                    let detailReport: ReportByCateModel = ReportByCateModel(nameType: incomeType.name!, percent: (tong / Double(commonReport.totalIncome!)!) * 100)
                    detailIncomeReport.append(detailReport)
                }
                
                for outcomeType in self.expenseTypeList {
                    var tong: Double = 0
                    
                    for transaction in self.transactionList {
                        if transaction.idType! == 0 && transaction.date! >= fromDate && transaction.date! <= toDate && transaction.nameType! == outcomeType.name!
                         {
                            tong += transaction.amount!
                        }
                    }
                    
                    let detailReport: ReportByCateModel = ReportByCateModel(nameType:
                        outcomeType.name!, percent: (tong / Double(commonReport.totalExpense!)!) * 100)
                    detailOutcomeReport.append(detailReport)
                }
            }
            
            print("Income")
            for detail in detailIncomeReport {
                print(detail.percent)
            }
            print("OutCome")
            for detail in detailOutcomeReport {
                print(detail.percent)
            }
            
            detailIncomeReport = self.modifyDetailData(detailData: detailIncomeReport)
            detailOutcomeReport = self.modifyDetailData(detailData: detailOutcomeReport)
            
            completionHandler(detailIncomeReport, detailOutcomeReport)
        })
    }
    
    func getDayOfCurrentWeek(weekDay: Int) -> Date {
        let cal = Calendar.current
        let date = Date()
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: date)
        comps.weekday = weekDay // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek
    }
    
    func getFirstDateOfMonth() -> String {
        let date = Date()
        dateFomatter.dateFormat = "dd/MM/yyyy"
        
        let comp: DateComponents = Calendar.current.dateComponents([.year, .month], from: date)
        let startOfMonth = Calendar.current.date(from: comp)!
        return dateFomatter.string(from: startOfMonth)
    }
    
    func getLastDateOfMont() -> String {
        dateFomatter.dateFormat = "dd/MM/yyyy"
        var comps2 = DateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = Calendar.current.date(byAdding: comps2, to: dateFomatter.date(from: getFirstDateOfMonth())!)
        return dateFomatter.string(from: endOfMonth!)
    }
    
    func modifyDetailData(detailData: [ReportByCateModel]) -> [ReportByCateModel] {
        var result: [ReportByCateModel] = []
        var detailList: [ReportByCateModel] = detailData
        
        if !detailList.isEmpty {
            detailList.sort(by: {$0.percent > $1.percent})
            for detail in detailList {
                detail.percent = Double(round(detail.percent * 10) / 10)
                if result.count < 4 {
                    result.append(detail)
                    
                    var tong: Double = 0;
                    for re in result {
                        tong += re.percent
                    }
                    
                    if 100 - tong < 5 || result.count == 3 {
                        let final = ReportByCateModel(nameType: "Others", percent: Double(round((100 - tong)*10)/10))
                        result.append(final)
                        break;
                    }
                }
            }
        }
        
        return result
    }
}
