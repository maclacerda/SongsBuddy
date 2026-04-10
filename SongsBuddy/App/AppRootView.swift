//
//  AppRootView.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/9/26.
//

import SBSongsFeature
import SwiftUI

struct AppRootView: View {
    let appDependencies: AppDependencies

    var body: some View {
        SongsView()
    }
}
