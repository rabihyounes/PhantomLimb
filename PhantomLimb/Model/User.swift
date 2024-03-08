//
//  User.swift
//  PhantomLimb
//
//  Created by xz353 on 2/20/24.
//

import SwiftUI

@Observable
class User: Codable {
    var id: String = ""
    var email: String = ""
    var isLogin: Bool = false
    var username: String = ""
    var cellnum: String = ""

    convenience init(id: String = "", email: String = "", isLogin: Bool, username: String = "", cellnum: String = "") {
        self.init()
        self.id = id
        self.email = email
        self.isLogin = isLogin
        self.username = username
        self.cellnum = cellnum
    }

    func signIn(email: String, password: String) -> Bool {
        if verifyCredentials(email: email, password: password) {
            self.email = email
            self.isLogin = true
            return true
        }
        return false
    }

    private func verifyCredentials(email: String, password: String) -> Bool {
        if email == "admin" && password == "1234" {
            return true
        }
        return false
    }
}
//
////admin user for testing purpose
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
