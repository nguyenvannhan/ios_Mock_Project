//
//  MainViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, UISearchResultsUpdating {
    
    var transactionList: [TransactionModel] = []
    var filteredList: [TransactionModel] = []
    let searchController = UISearchController(searchResultsController: nil)
    
    let daoTransactionList: DAOTransactionList = DAOTransactionList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInternet()
        configureNavigation()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        
        getData()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.actionLongPress(longPressRecognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkInternet()
        configureNavigation()
        
        getData()
    }
    
    //Configure Navigation for view
    func configureNavigation() {
        self.navigationItem.title = String(format: "%.0f", User.amount!) + " VNĐ"
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredList.count
        } else {
            return transactionList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
                    self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTransaction" {
            let indexPath = self.tableView.indexPathForSelectedRow
            
            let transactionModel: TransactionModel?
            
            if searchController.isActive && searchController.searchBar.text != "" {
                transactionModel = self.filteredList[(indexPath?.row)!]
            } else {
                transactionModel = self.transactionList[(indexPath?.row)!]
            }
            
            let editVC = segue.destination as! EditTransactionViewController
            editVC.transactionModel = transactionModel
        }
    }
    
    func actionLongPress(longPressRecognizer: UILongPressGestureRecognizer) {
        if longPressRecognizer.state == .began {
            let touchPoint = longPressRecognizer.location(in: self.view)
            if let indexPath = self.tableView.indexPathForRow(at: touchPoint) {
                let alertController = UIAlertController(title: "Delete Transaction", message: "Do you want to delete selected transaction?", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction) -> Void in
                    let transaction = self.transactionList[indexPath.row]
                    
                    self.deleteTransaction(transaction: transaction)
                })
                
                let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
                
                alertController.addAction(yesAction)
                alertController.addAction(noAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func deleteTransaction(transaction: TransactionModel) {
        checkInternet()
        
        KRActivityIn.startActivityIndicator(uiView: self.view)
        
        self.daoTransactionList.deleteTransaction(transactionModel: transaction, completionHandler: { (error) in
            if error == nil {
                let alertController = UIAlertController(title: "Success Delete", message: "Delete Success", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                self.configureNavigation()
                
                DispatchQueue.main.async {
                    self.getData()
                }
                
                KRActivityIn.stopActivityIndicator()
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                DispatchQueue.main.async {
                    self.getData()
                }
                
                KRActivityIn.stopActivityIndicator()
            }
        })
    }
    
    @IBAction func btnMenuClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.indexTemp = 0
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
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredList = []
        
        for transaction in transactionList {
            if transaction.note?.caseInsensitiveCompare(searchText) == ComparisonResult.orderedSame
            || transaction.nameType?.caseInsensitiveCompare(searchText) == ComparisonResult.orderedSame
                || transaction.date?.caseInsensitiveCompare(searchText) == ComparisonResult.orderedSame {
                filteredList.append(transaction)
            }
        }
        
        tableView.reloadData()
    }
}
