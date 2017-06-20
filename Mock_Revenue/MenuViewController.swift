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

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
            if indexTemp == 0 {
                self.navigationController?.popViewController(animated: true)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.navigationController?.viewControllers = [vc]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        if cell.lbMenuCellName.text == "Revenue Type" {
            if indexTemp == 1 {
                self.navigationController?.popViewController(animated: true)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CateViewController") as! CateViewController
                self.navigationController?.viewControllers = [vc]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        if cell.lbMenuCellName.text == "Report" {
            if indexTemp == 2 {
                self.navigationController?.popViewController(animated: true)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommonReportController") as! CommonReportController
                self.navigationController?.viewControllers = [vc]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        if cell.lbMenuCellName.text == "Change Password" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePassViewController") as! ChangePassViewController
            self.navigationController?.viewControllers = [vc]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if cell.lbMenuCellName.text == "Logout" {
            let daoUser = DAOUser()
            
            daoUser.logout(completionHandler: { (error) in
                if error == nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Can't Logout", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                }
            })
        }
    }

}
