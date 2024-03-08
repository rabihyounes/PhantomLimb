//
//  MeditationView.swift
//  PhantomLimb
//
//  Created by xz353 on 2/26/24.
//

import SwiftUI
import YouTubePlayerKit

struct MeditationView: View {
    @Environment(\.dismiss) private var dismiss

    let player1 = YouTubePlayer(source: .url("https://www.youtube.com/watch?v=J69ffbvR4-0"))
    let player2 = YouTubePlayer(source: .url("https://www.youtube.com/watch?v=UgRTd2V5054"))
    let player3 = YouTubePlayer(source: .url("https://www.youtube.com/watch?v=J69ffbvR4-0"))

    @State private var finish = false
    var body: some View {
        if !finish {
            ScrollView {
                VideoView(player: player1)
                VideoView(player: player2)
                VideoView(player: player3)
                MyCapsuleButton(buttontext: Text("Next"), buttonColor: .blue){
                    withAnimation{
                        finish = true
                    }
                }
                .padding()
            }
            .navigationBarBackButtonHidden()
        }
        else {
            MeditationFinishView(dismiss: dismiss)
                .transition(.scale)
        }
    }
}

struct VideoView: View {
    let player: YouTubePlayer
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color.gray)
            YouTubePlayerView(player)
                .frame(height: 250)
                .shadow(radius: 10)
                .padding(8)
        }
        .padding(5)
        .shadow(radius: 5)
    }
}

struct MeditationFinishView: View {
    var dismiss: DismissAction
    var body: some View {
        Text("Congratulations! You've finished.")
        MyCapsuleButton(buttontext: Text("Return"), buttonColor: .blue){
            dismiss()
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
        MeditationView()
}
