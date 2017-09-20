//
//  UIButton.swift
//  NovaCore
//

import UIKit

extension UIButton {
    
    public func setBackgroundColor(_ color: UIColor, forState state: UIControlState) {
        setBackgroundImage(color.pixel(), for: state)
    }
    
}
