//
//  PhantomLimbApp.swift
//  PhantomLimb
//
//  Created by xz353 on 2/14/24.
//

import SwiftData
import SwiftUI
import Firebase

@main
struct PhantomLimbApp: App {
    @StateObject var viewModel = ViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate                                                                                            
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

