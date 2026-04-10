//
//  AppRootView.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/9/26.
//

import SwiftUI

struct AppRootView: View {
    let appDependencies: AppDependencies

    var body: some View {
        Text("SongsBuddy")
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .background(Color.black)
    }
}
