//
//  MainPageView.swift
//  PhantomLimb
//
//  Created by xz353 on 2/21/24.
//

import SwiftUI

struct MainPageView: View {

    var body: some View {
        NavigationStack {
            TabView {
                Group {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .offset(CGSize(width: 0, height: -50))

                    TherapyView()
                        .tabItem {
                            Label("Therapy", systemImage: "pencil.and.list.clipboard")
                        }
                        .offset(CGSize(width: 0, height: -50))

                    Text("third Tab")
                        .tabItem {
                            Label("Progress", systemImage: "star")
                        }

                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.crop.circle")
                        }

                    Text("5th Tab")
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("PhantomRehab")
                        .font(.custom("Raleway SemiBold", size: 27))
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }

    }
}

#Preview {
    MainPageView()
}
