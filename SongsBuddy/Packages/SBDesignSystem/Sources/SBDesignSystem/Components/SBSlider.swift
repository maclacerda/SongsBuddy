//
//  SBSlider.swift
//  SBDesignSystem
//
//  Created by Marcos Ferreira on 4/17/26.
//

import SwiftUI
import UIKit

public struct SBSlider: UIViewRepresentable {
    // MARK: - Properties
    @Binding private var value: Double

    private let range: ClosedRange<Double>
    private let minimumTrackColor: UIColor
    private let maximumTrackColor: UIColor
    private let thumbColor: UIColor

    // MARK: - Initializer
    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        minimumTrackColor: UIColor = .white,
        maximumTrackColor: UIColor = UIColor.white.withAlphaComponent(0.2),
        thumbColor: UIColor = .white
    ) {
        self._value = value
        self.range = range
        self.minimumTrackColor = minimumTrackColor
        self.maximumTrackColor = maximumTrackColor
        self.thumbColor = thumbColor
    }

    // MARK: - Methods
    public func makeCoordinator() -> Coordinator {
        return Coordinator(value: $value)
    }

    public func makeUIView(
        context: Context
    ) -> UISlider {
        let slider = UISlider(frame: .zero)

        slider.minimumValue = Float(range.lowerBound)
        slider.maximumValue = Float(range.upperBound)
        slider.value = Float(value)

        slider.minimumTrackTintColor = minimumTrackColor
        slider.maximumTrackTintColor = maximumTrackColor

        slider.setThumbImage(
            Self.makeThumbImage(color: thumbColor),
            for: .normal
        )

        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )

        return slider
    }

    public func updateUIView(
        _ uiView: UISlider,
        context: Context
    ) {
        uiView.minimumValue = Float(range.lowerBound)
        uiView.maximumValue = Float(range.upperBound)

        if Double(uiView.value) != value {
            uiView.value = Float(value)
        }

        uiView.minimumTrackTintColor = minimumTrackColor
        uiView.maximumTrackTintColor = maximumTrackColor

        uiView.setThumbImage(
            Self.makeThumbImage(color: thumbColor),
            for: .normal
        )
    }

    private static func makeThumbImage(
        color: UIColor
    ) -> UIImage {
        let size = CGSize(
            width: 24,
            height: 24
        )

        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { context in
            let rect = CGRect(
                origin: .zero,
                size: size
            )

            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.fillEllipse(in: rect)
        }
    }
}

// MARK: - Coordinator
public extension SBSlider {
    final class Coordinator: NSObject {
        // MARK: - Properties
        private var value: Binding<Double>

        // MARK: - Initializer
        init(
            value: Binding<Double>
        ) {
            self.value = value
        }

        // MARK: - Methods
        @objc
        func valueChanged(
            _ sender: UISlider
        ) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
}
