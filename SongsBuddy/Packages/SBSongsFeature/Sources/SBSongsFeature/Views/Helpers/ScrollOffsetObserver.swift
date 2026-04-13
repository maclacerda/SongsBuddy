//
//  ScrollOffsetObserver.swift
//  SBSongsFeature
//
//  Created by Marcos Ferreira on 4/10/26.
//

import SwiftUI
import UIKit

/// Observes the content offset of the nearest enclosing `UIScrollView`.
struct ScrollOffsetObserver: UIViewRepresentable {
    // MARK: - Properties
    let onOffsetChange: (CGFloat) -> Void

    // MARK: - Initializer
    init(
        onOffsetChange: @escaping (CGFloat) -> Void
    ) {
        self.onOffsetChange = onOffsetChange
    }

    func makeUIView(
        context: Context
    ) -> ObserverView {
        let view = ObserverView()
        view.onOffsetChange = self.onOffsetChange

        return view
    }

    func updateUIView(
        _ uiView: ObserverView,
        context: Context
    ) {
        uiView.onOffsetChange = self.onOffsetChange
        uiView.attachIfNeeded()
    }
}

/// A helper view that attaches to the nearest enclosing `UIScrollView`.
final class ObserverView: UIView {
    // MARK: - Properties
    var onOffsetChange: ((CGFloat) -> Void)?
    private weak var observedScrollView: UIScrollView?
    private var contentOffsetObservation: NSKeyValueObservation?

    // MARK: - Lifecycle
    override func didMoveToWindow() {
        super.didMoveToWindow()

        self.attachIfNeeded()
    }

    deinit {
        self.contentOffsetObservation?.invalidate()
    }

    // MARK: - Methods
    func attachIfNeeded() {
        guard self.observedScrollView == nil else {
            return
        }

        guard let scrollView = self.enclosingScrollView() else {
            return
        }

        self.observedScrollView = scrollView
        self.contentOffsetObservation = scrollView.observe(
            \.contentOffset,
            options: [.initial, .new]
        ) { [weak self] scrollView, _ in
            let offset = scrollView.contentOffset.y

            DispatchQueue.main.async {
                self?.onOffsetChange?(offset)
            }
        }
    }

    private func enclosingScrollView() -> UIScrollView? {
        var currentView: UIView? = self

        while let view = currentView?.superview {
            if let scrollView = view as? UIScrollView {
                return scrollView
            }

            currentView = view
        }

        return nil
    }
}
