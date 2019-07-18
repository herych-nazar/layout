//
//  Anchor.swift
//  Nervy
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
    ///   - target: UIView or UILayoutGuide to which you want to attach
    ///   - anchorPoint: horizontal point at targetView
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    by anchorPoint: HorizontalPoint) -> NSLayoutConstraint {
        return anchor
            .constraint(equalTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .activate()
    }
    
    /// Create new GreaterThan constraint for anchor
    ///
    /// - Parameters:
    ///   - target: UIView or UILayoutGuide to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    greaterThan anchorPoint: HorizontalPoint) -> NSLayoutConstraint {
        return anchor
            .constraint(greaterThanOrEqualTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .activate()
    }
    
    /// Create new LessThan constraint for anchor
    ///
    /// - Parameters:
    ///   - target: UIView or UILayoutGuide to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    lessThan anchorPoint: HorizontalPoint) -> NSLayoutConstraint {
        return anchor
            .constraint(lessThanOrEqualTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .activate()
    }
    
    /// Create new constraint with multiplier for anchor
    ///
    /// - Parameters:
    ///   - target: UIView or UILayoutGuide to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    by anchorPoint: HorizontalPoint,
                    multiplier: CGFloat) -> NSLayoutConstraint {
        return anchor
            .constraint(equalTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .constraintWithMultiplier(multiplier)
            .activate()
    }
}

// MARK: - YAxis constraint
extension Anchor where A == NSLayoutYAxisAnchor {
    /// Create new constraint for anchor
    ///
    /// - Parameters:
    ///   - target: UIView or UILayoutGuide to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    by anchorPoint: VerticalPoint) -> NSLayoutConstraint {
        return anchor
            .constraint(equalTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .activate()
    }
    
    
    /// Create new GreaterThan constraint for anchor
    ///
    /// - Parameters:
    ///   - target: UIView or UILayoutGuide to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    greaterThan anchorPoint: VerticalPoint) -> NSLayoutConstraint {
        return anchor
            .constraint(greaterThanOrEqualTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .activate()
    }
    
    
    /// Create new LessThan constraint for anchor
    ///
    /// - Parameters:
    ///   - target: UIView or UILayoutGuide to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    lessThan anchorPoint: VerticalPoint) -> NSLayoutConstraint {
        return anchor
            .constraint(lessThanOrEqualTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .activate()
    }
    
    
    /// Create new constraint with multiplier for anchor
    ///
    /// - Parameters:
    ///   - target: UIView or UILayoutGuide to which you want to attach
    ///   - anchorPoint: vertical point at targetView
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    by anchorPoint: VerticalPoint,
                    multiplier: CGFloat) -> NSLayoutConstraint {
        return anchor
            .constraint(equalTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .constraintWithMultiplier(multiplier)
            .activate()
    }
}



// MARK: - XAxis constraint
extension Anchor where A == NSLayoutDimension {
    @discardableResult
    func constraint(to target: AnchorConvertible,
                    by anchorPoint: LayoutSize,
                    multiplier: CGFloat) -> NSLayoutConstraint {
        return anchor
            .constraint(equalTo: target.anchor(for: anchorPoint),
                        constant: anchorPoint.offset)
            .constraintWithMultiplier(multiplier)
            .activate()
    }
}
