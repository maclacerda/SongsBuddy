//
//  SongsBuddyApp.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/9/26.
//

import SwiftUI

@main
struct SongsBuddyApp: App {
    private let appDependencies = AppDependencies()

    var body: some Scene {
        WindowGroup {
            AppRootView(
                appDependencies: appDependencies
            )
        }
    }
}
