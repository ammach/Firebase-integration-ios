//
//  User.swift
//  test
//
//  Created by adhoc on 28/09/1437 AH.
//  Copyright © 1437 AH adhoc. All rights reserved.
//

import Foundation


class User{

    var uid:String=""
    let email:String
    let age:String
    
    
    init(uid:String,email:String,age:String){
    
        self.uid=uid
        self.email=email
        self.age=age
    }

    func toAnyObject()->AnyObject{
    return ["name":self.email,"age":self.age]
    }
    
    init(email:String,age:String){
        self.email=email
        self.age=age
    }

}