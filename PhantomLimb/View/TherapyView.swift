//
//  TherapyView.swift
//  PhantomLimb
//
//  Created by xz353 on 3/7/24.
//

import SwiftUI

struct TherapyView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Therapy")
                    .font(.custom("Raleway SemiBold", size: 27))
                    .offset(CGSize(width: 0, height: -40))
                    .shadow(radius: 10)
                MyNavigationButton(text: "Laterality Training") {
                    FAQView()//placerholder
                }
                MyNavigationButton(text: "Motor Imagery") {
                    FAQView()//placerholder
                }
                MyNavigationButton(text: "Mirror Therapy") {
                    MirrorTherapyView()
                }
            }
        }
    }
}

#Preview {
    TherapyView()
}
