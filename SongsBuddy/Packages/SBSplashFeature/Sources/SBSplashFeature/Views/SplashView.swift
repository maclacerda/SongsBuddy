//
//  SplashView.swift
//  SBSplashFeature
//
//  Created by Marcos Ferreira on 4/14/26.
//

import SBDesignSystem
import SwiftUI

public struct SplashView: View {
    // MARK: - Properties
    private let progress: Double

    // MARK: - Initializer
    public init(
        progress: Double
    ) {
        self.progress = progress
    }

    public var body: some View {
        ZStack {
            SBGradients.spotlight
                .ignoresSafeArea()

            VStack(
                spacing: .zero
            ) {
                Spacer()

                Image("ic-musical-note")
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 120,
                        height: 120
                    )

                Spacer()

                ProgressView(
                    value: progress,
                    total: 1.0
                )
                .tint(.white)
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
            }
        }
        .preferredColorScheme(.dark)
    }
}
