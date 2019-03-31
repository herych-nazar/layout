//
//  Anchor.swift
//  TestLayer
//
//  Created by Nazar on 3/26/19.
//  Copyright © 2019 Nazar. All rights reserved.
//

import UIKit

struct Anchor<A: LayoutAnchor> {
    private let anchor: A
    
    init(with anchor: A) {
        self.anchor = anchor
    }
}

// MARK: - XAxis constraint
extension Anchor where A == NSLayoutXAxisAnchor {
    /// Create new constraint for anchor
    ///
    /// - Parameters:
    ///   - targetView: to which you want to attach
    ///   - anchorPoint: horizontal point at targetView
    @discardableResult
    func constraint(to targetView: UIView,
                    by anchorPoint: HorizontalPoint) -> NSLayoutConstraint {
        return anchor
            .constraint(equalTo: targetView.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .activate()
    }
}

// MARK: - YAxis constraint
extension Anchor where A == NSLayoutYAxisAnchor {
    /// Create new constraint for anchor
    ///
    /// - Parameters:
    ///   - targetView: to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    func constraint(to targetView: UIView,
                    by anchorPoint: VerticalPoint) -> NSLayoutConstraint {
        return anchor
            .constraint(equalTo: targetView.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .activate()
    }
}
