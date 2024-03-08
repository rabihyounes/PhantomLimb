//
//  HomeView.swift
//  PhantomLimb
//
//  Created by xz353 on 2/21/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home")
                .font(.custom("Raleway SemiBold", size: 27))
                .offset(CGSize(width: 0, height: -40))
                .shadow(radius: 10)
            MyNavigationButton(text: "Meditation") {
                MeditationView()
            }
            MyNavigationButton(text: "Reminder") {
                FAQView()
            }
            MyNavigationButton(text: "FAQs") {
                FAQView()
            }
        }
    }
}

#Preview {
    HomeView()
}
