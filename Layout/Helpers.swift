//
//  Helpers.swift
//  TestLayer
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
    func activate() -> NSLayoutConstraint {
        isActive = true
        return self
    }
    
    func deactivate()  -> NSLayoutConstraint  {
        isActive = false
        return self
    }
}
