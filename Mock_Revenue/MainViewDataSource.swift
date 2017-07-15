//
//  MainViewDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for MainViewController class
// To configure Datasource and delegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    // Number Of Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Number of Rows in each Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //In searching
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredList.count
        } else { //Normal
            return transactionList.count
        }
    }
    
    //Format Cell to display on Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as! MainViewCell
        
        let transactionModel: TransactionModel?
        
        if searchController.isActive && searchController.searchBar.text != "" {
            transactionModel = filteredList[indexPath.row]
        } else {
            transactionModel = transactionList[indexPath.row]
        }
        
        // Configure the cell...
        cell.configureCell(transactionM: transactionModel!)
        
        return cell
    }
    
    //Get data from Firebase
    func getData() {
        KRActivityIn.startActivityIndicator(uiView: self.view)
        
        daoTransactionList.getTransactionList(completionHandler: { (transactionList, error) in
            if error == nil {
                self.transactionList = []
                self.transactionList = transactionList!
                self.transactionList.reverse()
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                    KRActivityIn.stopActivityIndicator()
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                KRActivityIn.stopActivityIndicator()
            }
        })
    }
    
    //Funtion check edit tableview
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // Delete row in tableview
        if editingStyle == .delete {
            let transaction: TransactionModel?
            
            if searchController.isActive && searchController.searchBar.text != "" {
                transaction = self.filteredList[(indexPath.row)]
            } else {
                transaction = self.transactionList[(indexPath.row)]
            }
            
            deleteTransaction(transaction: transaction!)
        }
    }
}
