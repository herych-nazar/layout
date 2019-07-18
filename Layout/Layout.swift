//
//  Layout.swift
//  Nervy
//
//  Created by Nazar on 3/25/19.
//  Copyright © 2019 Nazar. All rights reserved.
//

import UIKit

protocol Layout {
    /// Manage UIView's layout
    ///
    /// - Parameter manager: manage constraints of your view
    func layout(with manager: (LayoutManager)->Void)
}

protocol LayoutSizeable {
    /// Constraint sizes for view
    /// - Note: view will be constrained with fixed sizes and automaticaly be activated constraints
    /// - Parameter sizes: choose width or height, or both, with sizes you need
    /// - Returns: array of created constraints(in appropriate order)
    func size(_ sizes: LayoutSize...) -> [NSLayoutConstraint]
}

protocol EdgeConstrainable {
    /// Set appropriate constraints to view into targetView
    /// - Note: view will be constrained with fixed offset and automaticaly be activated constraints
    /// - Parameters:
    ///   - targetView: to which you want to attach
    ///   - edges: mutual edge point for view and targetView
    /// - Returns: array of created constraints(in appropriate order)
    func constraint(to target: AnchorConvertible, by edges: LayoutEdgePoint...) -> [NSLayoutConstraint]
    
    
    /// Set all edges constraints to view into target
    ///
    /// - Parameters:
    ///   - target: UIView or UILayoutGuide to which want to attach
    ///   - offset: equal offset for all edges
    /// - Returns: array of created constraints
    func constraint(to target: AnchorConvertible, offset: CGFloat) -> [NSLayoutConstraint]
}

protocol LayoutAnchor {
    func constraint(equalTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self,
                    constant: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: LayoutAnchor { }


// MARK: - Layout
extension UIView: Layout {
    func layout(with manager: (LayoutManager) -> Void) {
        allowAutoLayout()
        manager(LayoutManager(for: self))
    }
}

// MARK: -
class LayoutManager: LayoutSizeable, EdgeConstrainable {
    
    // MARK: - Properties
    private let view: UIView
    
    // MARK: - Anchors
    // XAxis
    lazy var trailing = Anchor(with: view.trailingAnchor)
    lazy var leading = Anchor(with: view.leadingAnchor)
    
    // YAxis
    lazy var top = Anchor(with: view.topAnchor)
    lazy var bottom = Anchor(with: view.bottomAnchor)
    
    // Center
    lazy var centerX = Anchor(with: view.centerXAnchor)
    lazy var centerY = Anchor(with: view.centerYAnchor)
    
    // MARK: - Constructor
    init(for view: UIView) {
        self.view = view
    }
    
    // MARK: - Methods
    @discardableResult
    func size(_ sizes: LayoutSize...) -> [NSLayoutConstraint] {
        return sizes.map { view.constraintSize($0) }
    }
    
    @discardableResult
    func constraint(to target: AnchorConvertible, by edges: LayoutEdgePoint...) -> [NSLayoutConstraint] {
        return edges.map { view.constraint(to: target, by: $0) }
    }
    
    @discardableResult
    func constraint(to target: AnchorConvertible, offset: CGFloat = 0) -> [NSLayoutConstraint] {
        return [.top(offset),
                .bottom(offset),
                .leading(offset),
                .trailing(offset)]
            .map { view.constraint(to: target, by: $0) }
    }
}

// MARK: - Sizes constraint
extension UIView {
    fileprivate func constraintSize(_ size: LayoutSize) -> NSLayoutConstraint {
        return anchor(for: size)
            .constraint(equalToConstant: size.offset)
            .activate()
    }
    
    func anchor(for layout: LayoutSize) -> NSLayoutDimension {
        switch layout {
        case .height:
            return heightAnchor
        case .width:
            return widthAnchor
        }
    }
}


// MARK: - Sizes anchor converter
extension UILayoutGuide {
    func anchor(for layout: LayoutSize) -> NSLayoutDimension {
        switch layout {
        case .height:
            return heightAnchor
        case .width:
            return widthAnchor
        }
    }
}

// MARK: - Edge constraint
extension UIView {
    fileprivate func constraint(to view: AnchorConvertible, by edge: LayoutEdgePoint) -> NSLayoutConstraint {
        switch edge {
        case .top, .bottom:
            guard let point = edge.verticalPoint else {
                fatalError("Can't convert to VerticalPoint")
            }
            
            return anchor(for: point)
                .constraint(equalTo: view.anchor(for: point), constant: edge.offset)
                .activate()
        case .leading, .trailing:
            guard let edgePoint = edge.horizontalPoint else {
                fatalError("Can't convert to HorizontalPoint")
            }
            
            return anchor(for: edgePoint)
                .constraint(equalTo: view.anchor(for: edgePoint), constant: edge.offset)
                .activate()
        }
    }
}

// MARK: - Anchor list
protocol Anchorable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: Anchorable { }
extension UILayoutGuide: Anchorable { }


// MARK: - Anchor converter
protocol AnchorConvertible {
    func anchor(for horizontal: HorizontalPoint) -> NSLayoutAnchor<NSLayoutXAxisAnchor>
    func anchor(for vertical: VerticalPoint) -> NSLayoutAnchor<NSLayoutYAxisAnchor>
    func anchor(for layout: LayoutSize) -> NSLayoutDimension
}

extension UIView: AnchorConvertible { }
extension UILayoutGuide: AnchorConvertible { }

extension AnchorConvertible where Self: Anchorable {
    func anchor(for horizontal: HorizontalPoint) -> NSLayoutAnchor<NSLayoutXAxisAnchor> {
        switch horizontal {
        case .leading:
            return leadingAnchor
        case .trailing:
            return trailingAnchor
        case .centerX:
            return centerXAnchor
        }
    }
    
    func anchor(for vertical: VerticalPoint) -> NSLayoutAnchor<NSLayoutYAxisAnchor> {
        switch vertical {
        case .top:
            return topAnchor
        case .bottom:
            return bottomAnchor
        case .centerY:
            return centerYAnchor
        }
    }
}
