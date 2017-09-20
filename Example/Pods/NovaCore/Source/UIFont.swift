//
//  UIFont.swift
//  NovaCore
//

import UIKit

extension UIFont {
    
    public func monospace() -> UIFont {
        let features = [
            [
                UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
            ]
        ]
        let monoDescriptor = fontDescriptor.addingAttributes(
            [UIFontDescriptor.AttributeName.featureSettings: features]
        )
        return UIFont(descriptor: monoDescriptor, size: pointSize)
    }
    
}
