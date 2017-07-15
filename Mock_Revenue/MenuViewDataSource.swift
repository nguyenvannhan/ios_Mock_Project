//
//  MenuViewDataSource.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/11/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

//Extension for MenuViewController class
// To configure Datasource and delegate
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    // Number Of Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuList.count
    }
    
    //Number of Rows in each Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuType = menuList[section]
        return (menuType.menus?.count)!
    }
    
    //Format Cell to display on Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuViewCell") as! MenuViewCell
        
        let menuType = menuList[indexPath.section]
        let menu = menuType.menus?[indexPath.row]
        
        // Configure the cell...
        cell.configureCell(menu: menu!)
        
        return cell
    }
    
    //Set title for Header of section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let menuType = menuList[section]
        return menuType.nameType
    }
    
    //Catch event click a row of tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = self.menuTableView.cellForRow(at: indexPath) as! MenuViewCell
        
        //Check Detail of Row and Push to viwe
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
        
        //If Logout, call to logout function and push to Login View
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
