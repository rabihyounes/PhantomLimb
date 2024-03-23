//
//  CameraHandler.swift
//  PhantomLimb
//
//  Created by xz353 on 3/8/24.
//

import SwiftUI

@Observable
final class CameraHandler{
    let camera = Camera()
    var viewfinderImage: Image?
    
    init(){
        Task{
            await handleCameraPreviews()
        }
    }
    
    func handleCameraPreviews() async {
        let imageStream = camera.previewStream
            .map { $0.image }

        for await image in imageStream {
            Task { @MainActor in
                viewfinderImage = image
            }
        }
    }
}

fileprivate extension CIImage {
    var image: Image? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }
}
