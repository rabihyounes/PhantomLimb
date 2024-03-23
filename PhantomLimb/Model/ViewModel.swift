//
//  AuthViewModel.swift
//  PhantomLimb
//
//  Created by Yuhan on 3/8/24.
//

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SwiftUI

enum LoginStatus {
    case SignedIn
    case SignedOut
}

//Data model for auth, store user therapy progress, etc..
class ViewModel: ObservableObject {
    private var uid: String?  //current signed in user id
    @Published var email: String?  //current signed in email
    @Published var loginstatus: LoginStatus =
        Auth.auth().currentUser == nil ? .SignedOut : .SignedIn

    init() {
        let currentUser = Auth.auth().currentUser
        self.uid = currentUser?.uid
        self.email = currentUser?.email
    }

    func signIn(withEmail email: String, password: String) {
        Auth.auth()
            .signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongself = self else { return }
                if error != nil {
                    print("Sign In failed:\(error!)")
                }
                else {
                    DispatchQueue.main.async {
                        strongself.uid = authResult?.user.uid
                        strongself.email = authResult?.user.email
                        strongself.loginstatus = .SignedIn
                    }
                }
            }
    }

    //create the user and store the user's info into firebase
    func createUser(
        withEmail email: String,
        password: String,
        cellnum: String,
        username: String
    ) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let currentUser = result.user
            let user = User(
                id: currentUser.uid,
                email: email,
                username: username,
                cellnum: cellnum
            )
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id)
                .setData(encodedUser)

            self.email = email
            self.uid = currentUser.uid
            self.loginstatus = .SignedIn
        }
        catch {
            print("DEBUG: Failed to create user: \(error)")
        }
    }

    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.loginstatus = .SignedOut
        }
        catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
