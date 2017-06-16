//
//  DAORevenueType.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/10/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DAORevenueType {
    
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    
    
    
    func getOutComeType(completionHandler: @escaping (_ revenueTypeList: [RevenueType]?, _ error: String?) -> Void) {
        var revenueTypeListc: [RevenueType] = []
        let uid = User.uid
        ref = Database.database().reference()
        
        
        handle = ref?.child("nguoi_dung").child(uid!).child("loai_chi").observe(.value, with: { (snapshot) in
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
    
    func getOutComeTypeFirst(completionHandler: @escaping (_ revenueTypeList: [RevenueType]?, _ error: String?) -> Void) {
        var revenueTypeListc: [RevenueType] = []
        ref = Database.database().reference()
        
        
        handle = ref?.child("loai_chi").observe(.value, with: { (snapshot) in
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
    
    func getInComeType(completionHandler: @escaping (_ revenueTypeList: [RevenueType]?, _ error: String?) -> Void) {
        var revenueTypeListc: [RevenueType] = []
        let uid = User.uid
        
        ref = Database.database().reference()
        
        handle = ref?.child("nguoi_dung").child(uid!).child("loai_thu").observe(.value, with: { (snapshot) in
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
    
    func getInComeTypeFirst(completionHandler: @escaping (_ revenueTypeList: [RevenueType]?, _ error: String?) -> Void) {
        var revenueTypeListc: [RevenueType] = []
        
        ref = Database.database().reference()
        
        handle = ref?.child("loai_thu").observe(.value, with: { (snapshot) in
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
