//
//  MoneyKeboard.swift
//  Mock_Revenue
//
//  Created by Nguyễn Văn Nhàn on 7/8/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import UIKit

class MoneyKeboard: UIView {

    weak var delegate: KeyboardDelegate?
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "moneyKeyboard" // xib extention not included
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    // MARK:- Button actions from .xib file
    
    @IBAction func keyTapped(sender: UIButton) {
        // When a button is tapped, send that information to the
        // delegate (ie, the view controller)
        // could alternatively send a tag value
        if sender.tag != 0 {
            self.delegate?.updateKeyboard(tag: sender.tag)
        } else {
            self.delegate?.keyWasTapped(character: sender.titleLabel!.text!)
        }
    }
    

}
