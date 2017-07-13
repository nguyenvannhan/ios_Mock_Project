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

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    
    var menuList: [TypeMenu] = TypeMenu.getList()
    
    @IBOutlet weak var menuTableView: UITableView!
    
    var indexTemp: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        
        configureNavigation()
        
        let commonFunction: CommonFunction = CommonFunction()
        lbName.text = User.name
        lbAge.text = String(describing: User.age ?? 0) + " tuổi"
        lbAmount.text = commonFunction.addDotText(text: String(format: "%g", User.amount ?? 0)) + " VNĐ"
        
        if User.amount! >= Double(0) {
            lbAmount.textColor = UIColor.blue
        } else {
            lbAmount.textColor = UIColor.red
        }
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
