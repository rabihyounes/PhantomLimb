//
//  User.swift
//  PhantomLimb
//
//  Created by xz353 on 2/20/24.
//

import SwiftUI

struct User: Codable {
    let id: String
    let email: String
    let username: String
    let cellnum: String
}


//class AdminUser: User {
//    var password: String
//
//    init() {
//        self.password = "12345"
//        super.init(email: "admin")
//    }
//
//    func signIn(email: String, password: String) -> Bool {
//        if email == self.email && password == self.password {
//            return true
//        }
//        return false
//    }
//
//    func changePassword() {
//        //TODO
//    }
//
//}
