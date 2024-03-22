//
//  ContentView.swift
//  PhantomLimb
//
//  Created by xz353 on 2/21/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(User.self) private var user
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
//        if !user.isLogin {
//            LoginPageView()
//        }
//        else {
//            MainPageView()
//        }
        if viewModel.userSession != nil {
            MainPageView()
        }
        else {
            LoginPageView()
        }
    }
}

#Preview {
    ContentView()
        .environment(User(isLogin: false))
}
