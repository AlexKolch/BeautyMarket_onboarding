//
//  SoundStream_OnboardingApp.swift
//  SoundStream_Onboarding
//
//  Created by Алексей Колыченков on 02.03.2025.
//

import SwiftUI
import SwiftfulRouting

@main
struct SoundStream_OnboardingApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { router in
                HomeView(vm: HomeViewVM(router: router))
            }
        }
    }
}


