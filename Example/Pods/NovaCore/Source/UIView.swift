//
//  UIView.swift
//  NovaCore
//

import UIKit

extension UIView {
    
    public func addParallax(_ parallax: UIOffset = UIOffset(horizontal: 15, vertical: 15)) {
        let group = UIMotionEffectGroup()
        let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontal.minimumRelativeValue = -parallax.horizontal
        horizontal.maximumRelativeValue = parallax.horizontal
        let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        vertical.minimumRelativeValue = -parallax.vertical
        vertical.maximumRelativeValue = parallax.vertical
        group.motionEffects = [horizontal, vertical]
        addMotionEffect(group)
    }
    
    public class func loadFromNibNamed<T: UIView>(_ nibNamed: String, bundle: Bundle? = nil, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> T? {
        return UINib(nibName: nibNamed, bundle: bundle).instantiate(withOwner: owner, options: options ?? [:])[0] as? T
    }
}
