//
//  PhantomLimbApp.swift
//  PhantomLimb
//
//  Created by xz353 on 2/14/24.
//

import SwiftData
import SwiftUI

@main
struct PhantomLimbApp: App {
    @State private var user: User = User()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(user)
        }
    }
}
