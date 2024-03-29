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
    @EnvironmentObject var viewModel: ViewModel

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
                    .autocapitalization(.none)
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
                    .autocapitalization(.none)
                Image("mail")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 15)
            }

            // password
            ZStack(alignment: .leading) {
                TextField("Enter password", text: $pw)
                    .textFieldStyle(CapsuleTextFieldStyle())
                Image("lock")
                    .resizable()
                    .frame(width: 30, height: 28)
                    .padding(.leading, 15)
            }
            
            // confirm password
            ZStack(alignment: .leading) {
                TextField("Confirm password", text: $confirm_pw)
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
                    dismiss()
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

#Preview {
    SignUpView()
        .environmentObject(ViewModel())
//        .environment(User())
}

