//
//  MenuViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

protocol GetMenuIndex {
    func setValueIndex(index: Int)
}

class MenuViewController: UIViewController {

    var menuList: [TypeMenu] = TypeMenu.getList()
    
    @IBOutlet weak var menuTableView: UITableView!
    
    var indexTemp: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureNavigation() {
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = true
    }
}
