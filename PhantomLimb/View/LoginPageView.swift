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

    var body: some View {
        VStack(alignment: .center) {
            Text("PhantomRehab")
                .font(.custom("Raleway SemiBold", size: 27))
                .offset(CGSize(width: 0, height: -60))
            Text("Sign In")
                .font(.custom("Nunito Regular", size: 27))

            ZStack(alignment: .leading) {
                TextField("Enter email", text: $email)
                    .textFieldStyle(CapsuleTextFieldStyle())
                Image("person-circle")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .padding(.leading, 15)
            }

            ZStack(alignment: .leading) {
                TextField("Enter password", text: $pw)
                    .textFieldStyle(CapsuleTextFieldStyle())
                Image("lock")
                    .resizable()
                    .frame(width: 30, height: 28)
                    .padding(.leading, 15)
            }

            Button {
                //TODO
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
            .padding(10)

            Button {
                //TODO
            } label: {
                Text("Sign Up")
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
}
