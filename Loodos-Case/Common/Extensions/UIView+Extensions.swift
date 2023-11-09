//
//  UIView+Extensions.swift
//  Loodos-Case
//
//  Created by Osman Yıldız on 8.11.2023.
//

import UIKit

extension UIView {
    
    func addBorder(width:CGFloat = 1, color: UIColor = .systemGray3, radius: CGFloat = 4) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
    
    func cornerRadius() {
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
}
