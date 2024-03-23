//
//  CameraView.swift
//  PhantomLimb
//
//  Created by xz353 on 3/8/24.
//

import SwiftUI

//Camera View
struct CameraView: View {
    @State private var cameraHandler = CameraHandler()
    @Environment(\.dismiss) private var dismiss
    private static let barHeightFactor = 0.15

    var body: some View {
        GeometryReader { geometry in
            ViewfinderView(image: $cameraHandler.viewfinderImage)
                .overlay(alignment: .center) {
                    Color.clear
                        .frame(height: geometry.size.height * (1 - (Self.barHeightFactor * 2)))
                        .accessibilityElement()
                        .accessibilityLabel("View Finder")
                        .accessibilityAddTraits([.isImage])
                }
                .overlay(alignment: .bottom) {
                    Color.black
                        .opacity(0.75)
                        .frame(height: geometry.size.height * Self.barHeightFactor)
                    VStack {
                        Text("Training time xx:xx")
                            .foregroundStyle(Color.white)
                        MyCapsuleButton(buttontext: Text("Finish"), buttonColor: .gray) {
                            dismiss()
                        }
                    }
                    .frame(height: geometry.size.height * Self.barHeightFactor)
                }
                .background(.black)
        }
        .task {
            await cameraHandler.camera.start()
        }
        .navigationTitle("Camera")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}

struct ViewfinderView: View {
    @Binding var image: Image?

    var body: some View {
        GeometryReader { geometry in
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    CameraView()
}
