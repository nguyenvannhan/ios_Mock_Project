//
//  MenuViewController.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var menuList: [TypeMenu] = TypeMenu.getList()
    
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuType = menuList[section]
        return (menuType.menus?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuViewCell") as! MenuViewCell
        
        let menuType = menuList[indexPath.section]
        let menu = menuType.menus?[indexPath.row]
        cell.configureCell(menu: menu!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let menuType = menuList[section]
        return menuType.nameType
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = self.menuTableView.cellForRow(at: indexPath) as! MenuViewCell
        
        if cell.lbMenuCellName.text == "Revenue List" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController")
            self.present(vc!, animated: true, completion: nil)
        }
    }

}
