//
//  AppRootView.swift
//  SongsBuddy
//
//  Created by Marcos Ferreira on 4/9/26.
//

import SBDesignSystem
import SwiftUI

struct AppRootView: View {
    let appDependencies: AppDependencies

    var body: some View {
        ZStack {
            SBColors.screenBackground
                .ignoresSafeArea()

            VStack(spacing: SBSpacingToken.spacing16.value) {
                Text("SongsBuddy")
                    .font(.sb(.display24))
                    .foregroundStyle(SBColors.primaryText)

                Text("Design System bootstrap is working.")
                    .font(.sb(.text16))
                    .foregroundStyle(SBColors.secondaryText)
            }
            .padding(SBSpacingToken.spacing24.value)
        }
    }
}
