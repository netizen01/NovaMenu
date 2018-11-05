//
//  UIColor.swift
//  NovaCore
//

import UIKit

extension UIColor {
    
    public func contrast() -> UIColor {
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // Counting the perceptive luminance - human eye favors green color...
        let luminance = 1 - ((0.299 * r) + (0.587 * g) + (0.114 * b))
        
        let d: CGFloat = luminance < 0.5 ? 0 : 1
        return UIColor(red: d, green: d, blue: d, alpha: a)
    }
    
    public func pixel() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.setFillColor(cgColor)
        ctx.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    public func resizableImage(_ cornerRadius: CGFloat) -> UIImage {
        let size = CGSize(width: cornerRadius * 2 + 1, height: cornerRadius * 2 + 1)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        setFill()
        UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: size), cornerRadius: cornerRadius).fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image.resizableImage(withCapInsets: UIEdgeInsets(top: cornerRadius, left: cornerRadius, bottom: cornerRadius, right: cornerRadius),
                                                 resizingMode: .stretch)
        
    }
    
    public func lighter(_ amount: CGFloat = 0.25) -> UIColor {
        return hueColorWithBrightnessAmount(1 + amount)
    }
    
    public func darker(_ amount: CGFloat = 0.25) -> UIColor {
        return hueColorWithBrightnessAmount(1 - amount)
    }
    
    public func hueColorWithBrightnessAmount(_ amount: CGFloat) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * amount, alpha: alpha)
        } else {
            return self
        }
    }
 
    
    
    
    public convenience init(rgba: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let hex = String(rgba.dropFirst())
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.count) {
                case 3:
                    red = CGFloat((hexValue & 0xF00) >> 8) / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4) / 15.0
                    blue = CGFloat(hexValue & 0x00F) / 15.0
                case 4:
                    red = CGFloat((hexValue & 0xF000) >> 12) / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8) / 15.0
                    blue = CGFloat((hexValue & 0x00F0) >> 4) / 15.0
                    alpha = CGFloat(hexValue & 0x000F) / 15.0
                case 6:
                    red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                    blue = CGFloat(hexValue & 0x0000FF) / 255.0
                case 8:
                    red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF) / 255.0
                default:
                    break;
                }
            }
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    public var rgba: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let redInt = Int(red * 255.99999)
            let greenInt = Int(green * 255.99999)
            let blueInt = Int(blue * 255.99999)
            let alphaInt = Int(alpha * 255.99999)
            return String(format: "#%02x%02x%02x%02x", redInt, greenInt, blueInt, alphaInt)
        }
        return "#000000"
    }
    
    
    
    /// Mixes the color with another color
    ///
    /// - parameter color: The color to mix with
    /// - parameter amount: The amount (0-1) to mix the new color in.
    /// - returns: A new UIColor instance representing the resulting color
    public func mixWithColor(_ color: UIColor, amount: Float) -> UIColor {
        var comp1r: CGFloat = 0
        var comp1g: CGFloat = 0
        var comp1b: CGFloat = 0
        var comp1a: CGFloat = 0
        self.getRed(&comp1r, green: &comp1g, blue: &comp1b, alpha: &comp1a)
        
        var comp2r: CGFloat = 0
        var comp2g: CGFloat = 0
        var comp2b: CGFloat = 0
        var comp2a: CGFloat = 0
        color.getRed(&comp2r, green: &comp2g, blue: &comp2b, alpha: &comp2a)
        
        let compr: CGFloat = comp1r + (comp2r - comp1r) * CGFloat(amount)
        let compg: CGFloat = comp1g + (comp2g - comp1g) * CGFloat(amount)
        let compb: CGFloat = comp1b + (comp2b - comp1b) * CGFloat(amount)
        let compa: CGFloat = comp1a + (comp2a - comp1a) * CGFloat(amount)
        
        return UIColor(red:compr, green: compg, blue: compb, alpha: compa)
    }
    
    
    /// Initializes UIColor with an integer.
    ///
    /// - parameter value: The integer value of the color. E.g. 0xFF0000 is red, 0x0000FF is blue.
    public convenience init(hex value: Int) {
        let components = getColorComponents(value)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: 1.0)
    }
    
    /// Initializes UIColor with an integer and alpha value.
    ///
    /// - parameter value: The integer value of the color. E.g. 0xFF0000 is red, 0x0000FF is blue.
    /// - parameter alpha: The alpha value.
    public convenience init(hex value: Int, alpha: CGFloat) {
        let components = getColorComponents(value)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: alpha)
    }
    
}

private func getColorComponents(_ value: Int) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    let r = CGFloat(value >> 16 & 0xFF) / 255.0
    let g = CGFloat(value >> 8 & 0xFF) / 255.0
    let b = CGFloat(value & 0xFF) / 255.0
    return (r, g, b)
}
