//
//  Menu.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

class Menu {
    var image: UIImage?
    var name: String?
    
    init(image: UIImage?, name: String?) {
        self.image = image
        self.name = name
    }
}

class TypeMenu {
    var nameType: String?
    var menus: [Menu]?
    
    init(nameType: String?, menus: [Menu]?) {
        self.nameType = nameType
        self.menus = menus
    }
    
    class func getList() -> [TypeMenu] {
        return [self.Manage_Wallet(), self.Invadially()]
    }
    
    class func Manage_Wallet() -> TypeMenu {
        var menus = [Menu]()
        
        menus.append(Menu(image: UIImage(named: "list.png"), name: "Revenue List"))
        menus.append(Menu(image: UIImage(named: "setting_1.png"), name: "Revenue Type"))
        menus.append(Menu(image: UIImage(named: "chart.png"), name: "Report"))
        
        return TypeMenu(nameType: "Wallet Management", menus: menus)
    }
    
    class func Invadially() -> TypeMenu {
        var menus = [Menu]()
        
        menus.append(Menu(image: UIImage(named: "setting_1.png"), name: "Change Password"))
        menus.append(Menu(image: UIImage(named: "setting.png"), name: "Logout"))
        
        return TypeMenu(nameType: "Invadually", menus: menus)
    }
}
