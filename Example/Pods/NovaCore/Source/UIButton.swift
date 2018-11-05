//
//  UIButton.swift
//  NovaCore
//

import UIKit

extension UIButton {
    
    public func templateImages() {
        templateImageForState(.normal)
        templateImageForState(.selected)
        templateImageForState(.highlighted)
        templateImageForState(.disabled)
    }
    
    public func templateImageForState(_ state: UIControl.State) {
        setImage(image(for: state)?.withRenderingMode(.alwaysTemplate), for: state)
    }
    
    public func setBackgroundColor(_ color: UIColor, forState state: UIControl.State) {
        setBackgroundImage(color.pixel(), for: state)
    }
    
}
