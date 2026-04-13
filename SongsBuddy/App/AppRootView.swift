//
//  AppRootView.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/9/26.
//

import SBData
import SBSongsFeature
import SwiftUI

struct AppRootView: View {
    // MARK: - Properties
    let appDependencies: AppDependencies

    var body: some View {
        SongsView(
            viewModel: SongsViewModel(
                repository: MusicRepositoryFactory.makeDefault()
            )
        )
    }
}
