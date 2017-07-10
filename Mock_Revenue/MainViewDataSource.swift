//
//  MainViewDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredList.count
        } else {
            return transactionList.count
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
