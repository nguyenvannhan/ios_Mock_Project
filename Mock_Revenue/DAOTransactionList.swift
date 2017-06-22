//
//  DAOTransactionList.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/15/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DAOTransactionList {
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    
    func getTransactionList(completionHandler: @escaping (_ transactionList: [TransactionModel]?, _ error: String?) -> Void) {
        var transactionList: [TransactionModel] = []
        
        let uid = User.uid
        ref = Database.database().reference()
        
        handle = ref?.child("nguoi_dung").child(uid!).child("giao_dich").queryOrdered(byChild: "ngay").observe(.value, with: { (snapshot) in
            if snapshot.exists() {
                if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshot {
                        if let postDict = snap.value as? [String: AnyObject] {
                            let transactionModel = TransactionModel(json: postDict)
                            transactionModel.key = snap.key
                            transactionList.append(transactionModel)
                        }
                    }
                }
                completionHandler(transactionList, nil)
            } else {
                let error = "Don't have transaction history. Click button Add (+) to create new!"
                
                completionHandler(nil, error)
            }
        })
    }
    
    func addNewTransaction(transactionModel: TransactionModel, completionHandler: @escaping (_ error: Error?) -> Void) {
        
        ref = Database.database().reference()
        let uid = User.uid
        let data = [
            "anh_loai": transactionModel.imageType!,
            "ten_loai": transactionModel.nameType!,
            "ma_loai": transactionModel.idType!,
            "dien_giai": transactionModel.note!,
            "so_tien": transactionModel.amount!,
            "ngay": transactionModel.date!
        ] as [String : Any]
        
        
        print(String(format: "%.0f", User.amount!))
            
        self.ref?.child("nguoi_dung").child(uid!).child("giao_dich").childByAutoId().setValue(data, withCompletionBlock: { (error, ref) in
            if error == nil {
                if transactionModel.idType == 0 {
                    User.amount = User.amount! - transactionModel.amount!
                } else {
                    User.amount = User.amount! + transactionModel.amount!
                }
                	
                self.ref?.child("nguoi_dung").child(uid!).updateChildValues(["luong_tien": User.amount!])
            }
            completionHandler(error)
        })
    }
    
    func editTransaction(currentAmount: Double, transactionModel: TransactionModel, completionHandler: @escaping (_ error: Error?) -> Void) {
        
        ref = Database.database().reference()
        let uid = User.uid
        let data = [
            "anh_loai": transactionModel.imageType!,
            "ten_loai": transactionModel.nameType!,
            "ma_loai": transactionModel.idType!,
            "dien_giai": transactionModel.note!,
            "so_tien": transactionModel.amount!,
            "ngay": transactionModel.date!
            ] as [String : Any]
        
        self.ref?.child("nguoi_dung").child(uid!).child("giao_dich").child(transactionModel.key!).updateChildValues(data, withCompletionBlock: { (error, ref) in
            if error == nil {
                if transactionModel.idType == 0 {
                    User.amount = User.amount! + currentAmount - transactionModel.amount!
                } else {
                    User.amount = User.amount! - currentAmount + transactionModel.amount!
                }
                
                self.ref?.child("nguoi_dung").child(uid!).updateChildValues(["luong_tien": User.amount!])
            }
            completionHandler(error)
        })
    }
    
    func deleteTransaction(transactionModel: TransactionModel, completionHandler: @escaping (_ error: Error?) -> Void) {
        ref = Database.database().reference()
        
        let uid = User.uid
        
        self.ref?.child("nguoi_dung").child(uid!).child("giao_dich").child(transactionModel.key!).removeValue(completionBlock: { (error, ref) in
            if error == nil {
                if transactionModel.idType == 0 {
                    User.amount = User.amount! +  transactionModel.amount!
                } else {
                    User.amount = User.amount! - transactionModel.amount!
                }
                
                self.ref?.child("nguoi_dung").child(uid!).updateChildValues(["luong_tien": User.amount!])
            }
            completionHandler(error)
        })
    }
}
