//
//  KRActivityIn.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/22/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import KRActivityIndicatorView

class KRActivityIn {
    static var activityIndicator: KRActivityIndicatorView = KRActivityIndicatorView()
    
    static func startActivityIndicator(uiView: UIView) {
        //activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .white
        activityIndicator.style = .gradationColor(head: .green, tail: .green)
        activityIndicator.layer.position = CGPoint(x: uiView.center.x - 35, y: uiView.center.y - 35)
        activityIndicator.layer.frame.size = CGSize(width: 70, height: 70)
        activityIndicator.layer.isHidden = false
        activityIndicator.isLarge = true
        uiView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    static func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.layer.isHidden = true
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
