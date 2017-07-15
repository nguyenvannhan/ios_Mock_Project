//
//  DAORevenueType.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import FirebaseDatabase


//Class connect Firebase and get Data about Revenue Type Of User
class DAORevenueType {
    
    var ref: DatabaseReference?
    
    //Funtion get Outcome Type
    func getOutComeType(completionHandler: @escaping (_ revenueTypeList: [RevenueType]?, _ error: String?) -> Void) {
        //Array to store Outcome Type
        var revenueTypeListc: [RevenueType] = []
        //Uid to get Outcome Type Of User
        let uid = User.uid
        //Construction connect variable
        ref = Database.database().reference()
        
        //Connect
         ref?.child("nguoi_dung").child(uid!).child("loai_chi").observeSingleEvent(of: .value, with: { (snapshot) in
            //Get data sucess
            if snapshot.exists() {
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshot {
                        //Get each row and add to list
                        if let postDict = snap.value as? [String: AnyObject] {
                            let revenueType = RevenueType(json: postDict)
                            revenueType.key = snap.key
                            revenueTypeListc.append(revenueType)
                        }
                    }
                }
                //Return result
                completionHandler(revenueTypeListc, nil)
            } else {
                //Error
                let error = "Can not get data"
                
                completionHandler(nil, error)
            }
        })
    }
    
    //Function connect Firebase and get Outcome Type (Common Outcome)
    func getOutComeTypeFirst(completionHandler: @escaping (_ revenueTypeList: [RevenueType]?, _ error: String?) -> Void) {
        var revenueTypeListc: [RevenueType] = []
        ref = Database.database().reference()
        
        
        ref?.child("loai_chi").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshot {
                        if let postDict = snap.value as? [String: AnyObject] {
                            let revenueType = RevenueType(json: postDict)
                            revenueType.key = snap.key
                            revenueTypeListc.append(revenueType)
                        }
                    }
                }
                completionHandler(revenueTypeListc, nil)
            } else {
                let error = "Can not get data"
                
                completionHandler(nil, error)
            }
        })
    }
    
    //Get Income Type For User
    func getInComeType(completionHandler: @escaping (_ revenueTypeList: [RevenueType]?, _ error: String?) -> Void) {
        var revenueTypeListc: [RevenueType] = []
        let uid = User.uid
        
        ref = Database.database().reference()
        
        ref?.child("nguoi_dung").child(uid!).child("loai_thu").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshot {
                        if let postDict = snap.value as? [String: AnyObject] {
                            let revenueType = RevenueType(json: postDict)
                            revenueType.key = snap.key
                            revenueTypeListc.append(revenueType)
                        }
                    }
                }
                completionHandler(revenueTypeListc, nil)
            } else {
                let error = "Can not get data"
                
                completionHandler(nil, error)
            }
        })
    }
    
    //Get Income Type (Common Type)
    func getInComeTypeFirst(completionHandler: @escaping (_ revenueTypeList: [RevenueType]?, _ error: String?) -> Void) {
        var revenueTypeListc: [RevenueType] = []
        
        ref = Database.database().reference()
        
        ref?.child("loai_thu").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshot {
                        if let postDict = snap.value as? [String: AnyObject] {
                            let revenueType = RevenueType(json: postDict)
                            revenueType.key = snap.key
                            revenueTypeListc.append(revenueType)
                        }
                    }
                }
                
                completionHandler(revenueTypeListc, nil)
            } else {
                let error = "Can not get data"
                
                completionHandler(nil, error)
            }
        })
    }
    
    //Add a new Revenue Type
    func addNewRevenueType(loaiChi: Bool, revenueType: RevenueType, completionHandler: @escaping (_ error: Error?) -> Void) {
        ref = Database.database().reference()
        let data = [
            "ten": revenueType.name!,
            "hinh_anh": revenueType.image! + ".png"
        ]
        
        let uid = User.uid
        
        if(loaiChi) {
            self.ref?.child("nguoi_dung").child(uid!).child("loai_chi").childByAutoId().setValue(data, withCompletionBlock: { (error, ref) in
                completionHandler(error)
            })
        } else {
            self.ref?.child("nguoi_dung").child(uid!).child("loai_thu").childByAutoId().setValue(data, withCompletionBlock: { (error, ref) in
                completionHandler(error)
            })
        }
    }
}
