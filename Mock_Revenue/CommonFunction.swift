//
//  CommonFunction.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import UIKit

class CommonFunction {
    //Ham kiem tra chuoii nhap vao co phai la email khong
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func readImageFromPlist() -> [String] {
        var imageList: [String] = []
        
        if let path = Bundle.main.path(forResource: "images", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
                for item in dict {
                    let img = item.value as? String
                    imageList.append(img!)
                }
            }
        }
        return imageList
    }
    
    func checkInternet() -> Bool{
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
        return flag
    }
    
    func addDotText(text: String) -> String {
        var flag: Bool = false
        var textCheck = text
        
        if textCheck.characters.count == 2 && textCheck.characters.first == "0" {
            textCheck.characters.removeFirst()
            return textCheck
        }
        if text.characters.first == "-" {
            flag = true
            textCheck.characters.removeFirst()
        }
        
        var tempText = ""
        let stringSeperate = textCheck.components(separatedBy: ".")
        
        if stringSeperate.count > 1 {
            for i in 0..<stringSeperate.count {
                tempText += stringSeperate[i]
            }
        } else {
            tempText = textCheck
        }
        return flag ? "-" + addDot(text: tempText) : addDot(text:tempText)
    }
    
    func addDot(text: String) -> String {
        
        var length = text.characters.count
        
        if length < 4 {
            return text
        } else {
            let surplus = length % 3
            let numberDot = (surplus == 0) ? ((length / 3) - 1) : (length / 3)
            
            if numberDot > 0 {
                var tempText = text
                var result = ""
                
                if surplus == 0 {
                    while length > 0 {
                        let endIndex = tempText.index(tempText.startIndex, offsetBy: 3)
                        let range = tempText.startIndex..<endIndex
                        result += tempText.substring(with: range)
                        if length > 3 {
                            result += "."
                        }
                        tempText.characters.removeFirst(3)
                        length = tempText.characters.count
                    }
                } else {
                    let end = tempText.index(tempText.startIndex, offsetBy: surplus)
                    let rangeTemp = tempText.startIndex..<end
                    result += tempText.substring(with: rangeTemp)
                    result += "."
                    tempText.characters.removeFirst(surplus)
                    length = tempText.characters.count
                    
                    while length > 0 {
                        let endIndex = tempText.index(tempText.startIndex, offsetBy: 3)
                        let range = tempText.startIndex..<endIndex
                        result += tempText.substring(with: range)
                        if length > 3 {
                            result += "."
                        }
                        tempText.characters.removeFirst(3)
                        length = tempText.characters.count
                    }
                }
                
                return result
            }
            return text
        }
    }
    
    func removeDotText(text: String) -> String {
        var tempText = ""
        let stringSeperate = text.components(separatedBy: ".")
        
        for i in 0..<stringSeperate.count {
            tempText += stringSeperate[i]
        }
        return tempText
    }
}
