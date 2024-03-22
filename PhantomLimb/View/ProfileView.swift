//
//  ProfileView.swift
//  PhantomLimb
//
//  Created by Yuhan on 3/7/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .center) {
//            Text("PhantomRehab")
//                .font(.custom("Raleway SemiBold", size: 27))
//                .offset(CGSize(width: 0, height: 40))
            
            Text("Profile")
                .font(.custom("Nunito Regular", size: 27))
                .offset(CGSize(width: 0, height: 70))
            Spacer()
            
            List {
                Section {
                    ZStack(alignment: .leading) {
                        Text("")
                            .textFieldStyle(CapsuleTextFieldStyle())
                        Image("person-circle")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.leading, 15)
                    }
                }
                
                Section {
                    ZStack(alignment: .leading) {
                        Text("")
                            .textFieldStyle(CapsuleTextFieldStyle())
                        Image("telephone")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.leading, 15)
                    }
                }
                
                
                Section {
                    ZStack(alignment: .leading) {
                        Text("")
                            .textFieldStyle(CapsuleTextFieldStyle())
                        Image("mail")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.leading, 15)
                    }
                }
                
                Section {
                    ZStack(alignment: .leading) {
                        Text("")
                            .textFieldStyle(CapsuleTextFieldStyle())
                        Image("lock")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.leading, 15)
                    }
                }
                
                Button {
                    
                } label: {
                    ZStack(alignment: .center) {
                        Capsule()
                            .frame(height: 45)
                            .containerRelativeFrame(.horizontal) { length, axis in
                                return length * 0.8
                            }
                        Text("Edit")
                            .foregroundStyle(Color.black)
                            .fontWeight(.semibold)
                    }
                }
                .padding(10)
            }
            .padding(.vertical, 80)
        }
    }
}

#Preview {
    ProfileView()
}
