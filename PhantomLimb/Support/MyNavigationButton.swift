//
//  MyNavigationButton.swift
//  PhantomLimb
//
//  Created by xz353 on 2/26/24.
//

import SwiftUI

struct MyNavigationButton<Content: View>: View {
    var text: String
    @ViewBuilder let destination: Content

    var body: some View {
        NavigationLink {
            destination
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("PhantomRehab")
                            .font(.custom("Raleway SemiBold", size: 27))
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                //.toolbarBackground(Color.blue, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        } label: {
            Capsule()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 55)
                .containerRelativeFrame(.horizontal) { length, axis in
                    return length * 0.55
                }
                .overlay {
                    Text(text)
                        .font(.custom("Raleway SemiBold", size: 20))
                        .foregroundStyle(Color.black)
                }
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 15, y: 15)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        }
        .padding(10)
    }
}


#Preview {
    MyNavigationButton(text: "hi"){
        FAQView()
    }
}
