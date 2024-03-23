//
//  MyCapsuleButton.swift
//  PhantomLimb
//
//  Created by xz353 on 3/7/24.
//

import SwiftUI

struct MyCapsuleButton: View {
    let buttontext:Text
    let buttonColor: Color
    let buttonAction:()->Void
    var body: some View {
        Button{
            buttonAction()
        }label: {
            Capsule()
                .foregroundStyle(buttonColor)
                .frame(width: 150, height: 50)
                .overlay {
                    buttontext
                        .foregroundStyle(Color.white)
                }
        }
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
    }
}

#Preview {
    MyCapsuleButton(buttontext: Text("Next"), buttonColor: Color.blue){
        return //button action trailing closure
    }
}
