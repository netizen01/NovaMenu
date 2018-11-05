//
//  UIImageView.swift
//  NovaCore
//

import UIKit

extension UIImageView {
    
    public func templateImage() {
        image = image?.withRenderingMode(.alwaysTemplate)
    }
}

