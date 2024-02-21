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
                MyNavigationButton(text: "Meditation") {
                    FAQView()
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

struct MyNavigationButton<Content: View>: View {
    var text: String
    @ViewBuilder let destination: Content

    var body: some View {
        NavigationLink {
            destination
        } label: {
            Capsule()
            .fill(Color.gray.opacity(0.3))
            .frame(height: 55)
            .containerRelativeFrame(.horizontal) { length, axis in
                return length * 0.55
            }
            .overlay{
                Text(text)
                    .font(.custom("Raleway SemiBold", size: 20))
                    .foregroundStyle(Color.black)
            }
        }
        .padding(10)
    }
}

#Preview {
    HomeView()
}
