//
//  ContentView.swift
//  PhantomLimb
//
//  Created by xz353 on 2/21/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        if Auth.auth().currentUser != nil {
            MainPageView()
        }
        else {
            LoginPageView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
