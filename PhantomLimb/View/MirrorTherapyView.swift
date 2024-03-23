//
//  MirrorTherapyView.swift
//  PhantomLimb
//
//  Created by xz353 on 3/7/24.
//

import SwiftUI

struct MirrorTherapyView: View {
    @State private var openCamera: Bool = false
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        if !openCamera {
            VStack {
                Text("save my progress placeholder")
                Text("Instruction placeholder")
                MyCapsuleButton(buttontext: Text("Next"), buttonColor: .blue) {
                    openCamera = true
                }
                MyCapsuleButton(buttontext: Text("Done"), buttonColor: .gray) {
                    //TODO save progress
                    dismiss()
                }
            }
            .navigationBarBackButtonHidden()
        }
        else {
            CameraView()
        }
    }
}

#Preview {
    MirrorTherapyView()
}
