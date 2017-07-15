//
//  DAOUser.swift
//  Mock_Revenue
//
//  Created by vannhan on 6/16/17.
//  Copyright © 2017 Cntt11. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

//Class connect Firebase and manage activity for User
class DAOUser {
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    
    let daoRevenueType: DAORevenueType = DAORevenueType()
    
    //Login
    func login(email: String, password: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let uid = user?.uid
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(password, forKey: "password")
                UserDefaults.standard.synchronize()
                
                self.ref = Database.database().reference()
                self.ref?.child("nguoi_dung").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        if let postDict = snapshot.value as? [String: AnyObject] {
                            User.setInfo(json: postDict)
                            User.email = email
                            User.uid = uid
                        }
                        
                        completionHandler(nil)
                    }
                })
            } else {
                completionHandler(error)
            }
        }
    }
    
    //Register an account
    func registry(email: String, password: String, name: String, age: Int, amount: Double, completionHandler: @escaping (_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                let uid = user?.uid
                
                self.ref = Database.database().reference()
                let data = [
                    "ten": name,
                    "tuoi": age,
                    "luong_tien": amount
                ] as [String : Any]
                self.ref?.child("nguoi_dung").child(uid!).setValue(data, withCompletionBlock: { (errorUser, ref) in
                    if errorUser == nil {
                        UserDefaults.standard.set(email, forKey: "email")
                        UserDefaults.standard.set(password, forKey: "password")
                        UserDefaults.standard.synchronize()
                        
                        User.setInfo(name: name, age: age, amount: amount)
                        User.email = email
                        User.uid = uid!
                        self.daoRevenueType.getInComeTypeFirst(completionHandler: { (expenseTypeList, error) in
                            for expenseType in expenseTypeList! {
                                let data = [
                                    "ten": expenseType.name,
                                    "hinh_anh": expenseType.image!
                                ] as [String: AnyObject]
                                
                                self.ref?.child("nguoi_dung").child(uid!).child("loai_thu").childByAutoId().setValue(data)
                            }
                            self.daoRevenueType.getOutComeTypeFirst(completionHandler: { (expenseTypeList, error) in
                                for expenseType in expenseTypeList! {
                                    let data = [
                                        "ten": expenseType.name,
                                        "hinh_anh": expenseType.image!
                                        ] as [String: AnyObject]
                                    
                                    self.ref?.child("nguoi_dung").child(uid!).child("loai_chi").childByAutoId().setValue(data)
                                }
                                completionHandler(nil)
                            })
                        })
                    }
                })
            } else {
                completionHandler(error)
            }
        })
    }
    
    //Function change Pass
    func changePassword(currentPassword: String, newPassword: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: User.email!, password: currentPassword)
        
        user?.reauthenticate(with: credential, completion: { (error) in
            if error != nil{
                completionHandler(error)
            }else{
                Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
                    UserDefaults.standard.set(newPassword, forKey: "password")
                    UserDefaults.standard.synchronize()
                    completionHandler(error)
                })
            }
        })
    }
    
    //Logout
    func logout(completionHandler: @escaping (_ error: Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.set("", forKey: "email")
            UserDefaults.standard.set("", forKey: "password")
            UserDefaults.standard.synchronize()
            
            completionHandler(nil)
        } catch let signOutError as NSError {
            completionHandler(signOutError)
        }
    }
    
    //Reset Password
    func resetPassword(email: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            completionHandler(error)
        })
    }
}
