//
//  Helpers.swift
//  Nervy
//
//  Created by Nazar on 3/26/19.
//  Copyright © 2019 Nazar. All rights reserved.
//

import UIKit

extension UIView {
    func allowAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension NSLayoutConstraint {
    @discardableResult
    func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }
    
    @discardableResult
    func deactivate()  -> NSLayoutConstraint  {
        isActive = false
        return self
    }
    
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstItem,
                                  attribute: firstAttribute,
                                  relatedBy: relation,
                                  toItem: secondItem,
                                  attribute: secondAttribute,
                                  multiplier: multiplier,
                                  constant: constant)
    }
}
