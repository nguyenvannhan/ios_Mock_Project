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

class DAOUser {
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    
    func login(email: String, password: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let uid = Auth.auth().currentUser?.uid
                
                self.ref = Database.database().reference()
                self.handle = self.ref?.child("nguoi_dung").child(uid!).observe(.value, with: { (snapshot) in
                    if snapshot.exists() {
                        print(snapshot)
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
    
    func changePassword(currentPassword: String, newPassword: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: User.email!, password: currentPassword)
        
        user?.reauthenticate(with: credential, completion: { (error) in
            if error != nil{
                completionHandler(error)
            }else{
                Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
                    completionHandler(error)
                })
            }
        })
    }
}
