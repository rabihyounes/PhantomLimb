//
//  LoginPageView.swift
//  PhantomLimb
//
//  Created by xz353 on 2/19/24.
//

import SwiftUI

struct LoginPageView: View {
    @State private var email: String = ""
    @State private var pw: String = ""
    @State private var wrong_pw: Bool = false
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Text("PhantomRehab")
                    .font(.custom("Raleway SemiBold", size: 27))
                    .offset(CGSize(width: 0, height: -140))

                Text("Sign In")
                    .font(.custom("Nunito Regular", size: 27))

                //Username / Email
                ZStack(alignment: .leading) {
                    TextField("Enter email", text: $email)
                        .textFieldStyle(CapsuleTextFieldStyle())
                        .autocapitalization( /*@START_MENU_TOKEN@*/.none /*@END_MENU_TOKEN@*/)
                    Image("person-circle")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .padding(.leading, 15)
                }

                //Password
                ZStack(alignment: .leading) {
                    SecureField("Enter password", text: $pw)
                        .textFieldStyle(CapsuleTextFieldStyle())
                    Image("lock")
                        .resizable()
                        .frame(width: 30, height: 28)
                        .padding(.leading, 15)
                }

                //Login Button
                Button {
                    viewModel.signIn(withEmail: email, password: pw)
                } label: {
                    ZStack {
                        Capsule()
                            .frame(height: 45)
                            .containerRelativeFrame(.horizontal) { length, axis in
                                return length * 0.4
                            }
                        Text("Login")
                            .foregroundStyle(Color.black)
                    }
                }
                .alert(isPresented: $wrong_pw) {
                    Alert(title: Text("Wrong Account"))

                }
                .padding(10)

                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 2) {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight( /*@START_MENU_TOKEN@*/.bold /*@END_MENU_TOKEN@*/)
                    }
                }
                .padding(10)

                Button {
                    //TODO
                } label: {
                    Text("Forget my password")
                }
                .padding(10)
            }
        }
    }
}

struct CapsuleTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(EdgeInsets(top: 25, leading: 60, bottom: 25, trailing: 16))
            .background(
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 50)
            )
            .containerRelativeFrame(.horizontal) { length, axis in
                return length * 0.7
            }
    }
}

#Preview {
    LoginPageView()
        .environmentObject(ViewModel())
}
