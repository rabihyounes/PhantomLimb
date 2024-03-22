//
//  AuthViewModel.swift
//  PhantomLimb
//
//  Created by Yuhan on 3/8/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        
    }
    
    func createUser(withEmail email: String, password: String, cellnum: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email, isLogin: false, username: username, cellnum: cellnum)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        }
        catch {
            print("DEBUG: Failed to create user")
        }
    }
    
    func signOut() {
        
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
    }
}
