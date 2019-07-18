//
//  LayoutEnums.swift
//  Nervy
//
//  Created by Nazar on 3/26/19.
//  Copyright © 2019 Nazar. All rights reserved.
//

import UIKit

protocol Offsetable {
    var offset: CGFloat { get }
}

extension Offsetable {
    var offset: CGFloat {
        let value = Mirror(reflecting: self).children.first?.value as? CGFloat
        return value ?? 0
    }
}

enum LayoutSize: Offsetable  {
    case height(CGFloat)
    case width(CGFloat)
}

enum LayoutEdgePoint: Offsetable {
    case top(CGFloat)
    case bottom(CGFloat)
    
    case leading(CGFloat)
    case trailing(CGFloat)
    
    var verticalPoint: VerticalPoint? {
        switch self {
        case .top:
            return .top(offset)
        case .bottom:
            return .bottom(offset)
        default:
            return nil
        }
    }
    
    var horizontalPoint: HorizontalPoint? {
        switch self {
        case .leading:
            return .leading(offset)
        case .trailing:
            return .trailing(offset)
        default:
            return nil
        }
    }
}

enum HorizontalPoint: Offsetable {
    case leading(CGFloat)
    case trailing(CGFloat)
    case centerX(CGFloat)
}

enum VerticalPoint: Offsetable {
    case top(CGFloat)
    case bottom(CGFloat)
    case centerY(CGFloat)
}
