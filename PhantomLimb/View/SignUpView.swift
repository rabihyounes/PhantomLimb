//
//  SignUpView.swift
//  PhantomLimb
//
//  Created by Yuhan on 3/7/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var pw: String = ""
    @State private var username: String = ""
    @State private var cellnum: String = ""
    @State private var confirm_pw: String = ""
    @Environment(\.dismiss) var dismiss
//    @Environment(User.self) private var user
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack(alignment: .center) {
            Text("PhantomRehab")
                .font(.custom("Raleway SemiBold", size: 27))
                .offset(CGSize(width: 0, height: -50))

            Text("Create Account")
                .font(.custom("Nunito Regular", size: 27))

            // username
            ZStack(alignment: .leading) {
                TextField("Enter username", text: $username)
                    .textFieldStyle(CapsuleTextFieldStyle())
                Image("person-circle")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 15)
            }
            
            // cell number
            ZStack(alignment: .leading) {
                TextField("Enter cell number", text: $cellnum)
                    .textFieldStyle(CapsuleTextFieldStyle())
                Image("telephone")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 15)
            }
            
            // email
            ZStack(alignment: .leading) {
                TextField("Enter email", text: $email)
                    .textFieldStyle(CapsuleTextFieldStyle())
                Image("mail")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 15)
            }

            // password
            ZStack(alignment: .leading) {
                SecureField("Enter password", text: $pw)
                    .textFieldStyle(CapsuleTextFieldStyle())
                Image("lock")
                    .resizable()
                    .frame(width: 30, height: 28)
                    .padding(.leading, 15)
            }
            
            // confirm password
            ZStack(alignment: .leading) {
                SecureField("Confirm password", text: $confirm_pw)
                    .textFieldStyle(CapsuleTextFieldStyle())
                Image("lock")
                    .resizable()
                    .frame(width: 30, height: 28)
                    .padding(.leading, 15)
            }

            // sign up button
            Button {
                Task {
                    try await viewModel.createUser(withEmail: email,
                                                   password: pw,
                                                   cellnum: cellnum,
                                                   username: username)
                }
            } label: {
                ZStack {
                    Capsule()
                        .frame(height: 45)
                        .containerRelativeFrame(.horizontal) { length, axis in
                            return length * 0.4
                        }
                    Text("Sign Up")
                        .foregroundStyle(Color.black)
                        .fontWeight(.semibold)
                }
            }
            .padding(10)

            Button {
                dismiss()
            } label: {
                HStack(spacing: 2) {
                    Text("Already have an account?")
                }
                Text("Login")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            .padding(10)
        }
    }
}

//struct CapsuleTextFieldStyle: TextFieldStyle {
//    func _body(configuration: TextField<Self._Label>) -> some View {
//        configuration
//            .padding(EdgeInsets(top: 25, leading: 60, bottom: 25, trailing: 16))
//            .background(
//                Capsule()
//                    .fill(Color.gray.opacity(0.3))
//                    .frame(height: 50)
//            )
//            .containerRelativeFrame(.horizontal) { length, axis in
//                return length * 0.7
//            }
//    }
//}

#Preview {
    SignUpView()
//        .environment(User())
}

