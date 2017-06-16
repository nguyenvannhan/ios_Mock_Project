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
                    if transaction.date == date {
                        if transaction.idType == 0 {
                            totalExpense += transaction.amount!
                            totalBalance += transaction.amount!
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
                            totalBalance += transaction.amount!
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
                            totalBalance += transaction.amount!
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
}
