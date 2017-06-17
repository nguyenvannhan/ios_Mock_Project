//
//  MainViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var transactionList: [TransactionModel] = []
    
    let daoTransactionList: DAOTransactionList = DAOTransactionList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
        
        getData()
    }
    
    func configureNavigation() {
        self.navigationItem.title = String(format: "%g", User.amount!)
        
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
        return transactionList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as! MainViewCell
        let transactionModel = transactionList[indexPath.row]
        
        // Configure the cell...
        cell.configureCell(transactionM: transactionModel)

        return cell
    }
    
    func getData() {
        daoTransactionList.getTransactionList(completionHandler: { (transactionList, error) in
            if error == nil {
                self.transactionList = []
                self.transactionList = transactionList!
                self.transactionList.reverse()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditTransaction" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let transactionModel = self.transactionList[(indexPath?.row)!]
            
            let editVC = segue.destination as! EditTransactionViewController
            editVC.transactionModel = transactionModel
        }
    }
    
    @IBAction func btnMenuClick(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        vc.indexTemp = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
