//
//  AppRootView.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/9/26.
//

import SBData
import SBSongsFeature
import SBSplashFeature
import SwiftUI

struct AppRootView: View {
    // MARK: - Properties
    let appDependencies: AppDependencies

    @State private var isShowingSplash: Bool = true
    @State private var splashProgress: Double = .zero

    var body: some View {
        Group {
            if isShowingSplash {
                SplashView(
                    progress: splashProgress
                )
            } else {
                let viewModel = SongsViewModel(
                    repository: MusicRepositoryFactory.makeDefault(),
                    recentlyPlayedRepository: appDependencies.recentlyPlayedRepository
                )

                SongsView(
                    viewModel: viewModel,
                    recentlyPlayedRepository: appDependencies.recentlyPlayedRepository
                )
            }
        }
        .task {
            guard isShowingSplash else {
                return
            }

            for step in 1...12 {
                try? await Task.sleep(for: .milliseconds(100))
                splashProgress = Double(step) / 12.0
            }

            /// wait more 1 sec complete the progress view before to show the home view
            try? await Task.sleep(for: .milliseconds(100))
            isShowingSplash = false
        }
    }
}
