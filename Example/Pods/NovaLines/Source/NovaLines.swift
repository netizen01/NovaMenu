//
//  NovaLineButton
//
//  Inspired By: https://github.com/victorBaro/VBFPopFlatButton
//

import UIKit

public enum NovaLineType: String {
    case line
    case line2
    case line3
    case minus
    case menu2
    case menu3
    case close
    case add
    case square
    case left
    case right
    case up
    case down
    case left2
    case right2
    case up2
    case down2
    case download
    case download2
    case upload2
    case upload
    case rightTriangle
    case upTriangle
    case leftTriangle
    case downTriangle
    case check
}

@IBDesignable public class NovaLineView: UIView {
    
    @IBInspectable public var lineColor: UIColor = .white {
        didSet {
            segment1.lineColor = lineColor
            segment2.lineColor = lineColor
            segment3.lineColor = lineColor
        }
    }
    
    @IBInspectable public var animationSpringDamping: CGFloat = 0.7    // 0 = more spring. 1 = no spring
    @IBInspectable public var animationSpringVelocity: CGFloat = 0.5
    @IBInspectable public var animationDuration: Double = 0.5
    @IBInspectable public var triangleCompact: CGFloat = 0.8
    @IBInspectable public var inset: CGFloat = 0
    
    public var type: NovaLineType = .line {
        didSet {
            var center1 = CGPoint(x: bounds.midX, y: bounds.midY)
            var center2 = center1
            var center3 = center1
            
            let halfLength = lineLength * 0.5
            let halfThickness = lineThickness * 0.5
            let trianglePointMod: CGFloat = 0.90588
            let triangleBaseMod: CGFloat = 0.82353
            
            
            switch type {
            case .line:
                segment1.angle = Angle(0, 180)
                segment2.angle = Angle(0, 180)
                segment3.angle = Angle(0, 180)
                
            case .line2:
                segment1.angle = Angle(0, 180)
                segment2.angle = Angle(0, 180)
                segment3.angle = Angle(0, 180)
                center1.x = center1.x - lineLength * 0.3
                center2.x = center2.x + lineLength * 0.3
                center3 = center2
                
            case .line3:
                segment1.angle = Angle(0, 180)
                segment2.angle = Angle(0, 180)
                segment3.angle = Angle(0, 180)
                center1.x = center1.x - lineLength * 0.6
                center3.x = center3.x + lineLength * 0.6
                
                
            case .minus:
                segment1.angle = Angle(90, 180)
                segment2.angle = Angle(90, 180)
                segment3.angle = Angle(90, 180)
                
            case .menu2:
                segment1.angle = Angle(90, 180)
                segment2.angle = Angle(90, 180)
                segment3.angle = Angle(90, 180)
                center1.y = center1.y - lineLength * 0.3
                center2.y = center2.y + lineLength * 0.3
                center3 = center2
                
            case .menu3:
                segment1.angle = Angle(90, 180)
                segment2.angle = Angle(90, 180)
                segment3.angle = Angle(90, 180)
                center1.y = center1.y - lineLength * 0.6
                center3.y = center3.y + lineLength * 0.6
                
            case .add:
                segment1.angle = Angle(90, 180)
                segment2.angle = Angle(0, 180)
                segment3.angle = Angle(0, 180)
                
            case .close:
                segment1.angle = Angle(45, 180)
                segment2.angle = Angle(135, 180)
                segment3.angle = Angle(135, 180)
                
            case .square:
                segment1.angle = Angle(135, 90)
                segment2.angle = Angle(315, 90)
                segment3.angle = Angle(315, 90)
                center1.x = center1.x - halfLength + halfThickness
                center2.x = center2.x + halfLength - halfThickness
                center1.y = center1.y - halfLength + halfThickness
                center2.y = center2.y + halfLength - halfThickness
                center3 = center2
                
            case .left:
                segment1.angle = Angle(225, 0)
                segment2.angle = Angle(135, 0)
                segment3.angle = Angle(135, 0)
                center1.x = center1.x - halfLength + halfThickness
                center2 = center1
                center3 = center1
                
            case .right:
                segment1.angle = Angle(315, 0)
                segment2.angle = Angle(45, 0)
                segment3.angle = Angle(45, 0)
                center1.x = center1.x + halfLength - halfThickness
                center2 = center1
                center3 = center1
                
            case .up:
                segment1.angle = Angle(45, 0)
                segment2.angle = Angle(135, 0)
                segment3.angle = Angle(135, 0)
                center1.y = center1.y - halfLength + halfThickness
                center2 = center1
                center3 = center1
                
            case .down:
                segment1.angle = Angle(225, 0)
                segment2.angle = Angle(315, 0)
                segment3.angle = Angle(315, 0)
                center1.y = center1.y + halfLength - halfThickness
                center2 = center1
                center3 = center1
                
            case .left2:
                segment1.angle = Angle(180, 90)
                segment2.angle = Angle(180, 90)
                segment3.angle = Angle(180, 90)
                center1.x = center1.x - lineLength * 0.8 + halfThickness
                center2.x = center2.x + halfThickness
                center3 = center2
                
            case .right2:
                segment1.angle = Angle(0, 90)
                segment2.angle = Angle(0, 90)
                segment3.angle = Angle(0, 90)
                center1.x = center1.x - halfThickness
                center2.x = center2.x + lineLength * 0.8 - halfThickness
                center3 = center2
                
            case .up2:
                segment1.angle = Angle(90, 90)
                segment2.angle = Angle(90, 90)
                segment3.angle = Angle(90, 90)
                center1.y = center1.y - lineLength * 0.8 + halfThickness
                center2.y = center2.y + halfThickness
                center3 = center2
                
            case .down2:
                segment1.angle = Angle(270, 90)
                segment2.angle = Angle(270, 90)
                segment3.angle = Angle(270, 90)
                center1.y = center1.y - halfThickness
                center2.y = center2.y + lineLength * 0.8 - halfThickness
                center3 = center2
                
            case .download:
                segment1.angle = Angle(270, 90)
                segment2.angle = Angle(0, 180)
                segment3.angle = Angle(0, 180)
                center1.y = center1.y + lineLength - lineThickness
                
            case .upload:
                segment1.angle = Angle(90, 90)
                segment2.angle = Angle(0, 180)
                segment3.angle = Angle(0, 180)
                center1.y = center1.y - lineLength + lineThickness
                
            case .download2:
                segment1.angle = Angle(270, 90)
                segment2.angle = Angle(0, 180)
                segment3.angle = Angle(90, 180)
                center1.y = center1.y + lineLength - lineThickness
                center3.y = center3.y + lineLength
                
            case .upload2:
                segment1.angle = Angle(90, 90)
                segment2.angle = Angle(0, 180)
                segment3.angle = Angle(90, 180)
                center1.y = center1.y - lineLength + lineThickness
                center3.y = center3.y - lineLength
                
            case .upTriangle:
                segment1.angle = Angle(90, 60)
                segment2.angle = Angle(330, 60)
                segment3.angle = Angle(210, 60)
                center1.y = center1.y - lineLength * trianglePointMod * triangleCompact
                center2.y = center2.y + lineLength * triangleBaseMod * triangleCompact
                center2.x = center2.x + lineLength * triangleCompact
                center3.y = center3.y + lineLength * triangleBaseMod * triangleCompact
                center3.x = center3.x - lineLength * triangleCompact
                
            case .downTriangle:
                segment1.angle = Angle(270, 60)
                segment2.angle = Angle(150, 60)
                segment3.angle = Angle(30, 60)
                center1.y = center1.y + lineLength * trianglePointMod * triangleCompact
                center2.y = center2.y - lineLength * triangleBaseMod * triangleCompact
                center2.x = center2.x - lineLength * triangleCompact
                center3.y = center3.y - lineLength * triangleBaseMod * triangleCompact
                center3.x = center3.x + lineLength * triangleCompact
                
            case .leftTriangle:
                segment1.angle = Angle(180, 60)
                segment2.angle = Angle(60, 60)
                segment3.angle = Angle(300, 60)
                center1.x = center1.x - lineLength * trianglePointMod * triangleCompact
                center2.y = center2.y - lineLength * triangleCompact
                center2.x = center2.x + lineLength * triangleBaseMod * triangleCompact
                center3.y = center3.y + lineLength * triangleCompact
                center3.x = center3.x + lineLength * triangleBaseMod * triangleCompact
                
            case .rightTriangle:
                segment1.angle = Angle(0, 60)
                segment2.angle = Angle(240, 60)
                segment3.angle = Angle(120, 60)
                center1.x = center1.x + lineLength * trianglePointMod * triangleCompact
                center2.y = center2.y + lineLength * triangleCompact
                center2.x = center2.x - lineLength * triangleBaseMod * triangleCompact
                center3.x = center3.x - lineLength * triangleBaseMod * triangleCompact
                center3.y = center3.y - lineLength * triangleCompact
                
            case .check:
                segment1.angle = Angle(270, 90)
                segment2.angle = Angle(225, 0)
                segment3.angle = Angle(225, 0)
                center1.y = center1.y + lineLength * 0.8
                center1.x = center1.x - lineLength * 0.2
                center2.y = center2.y + lineLength * 0.4
                center2.x = center2.x + lineLength * 0.2
                center3 = center2
            }
            
            segment1.center = center1
            segment2.center = center2
            segment3.center = center3
        }
    }
    @IBInspectable public var lineRadius: CGFloat = 2 {
        didSet {
            segment1.radius = lineRadius
            segment2.radius = lineRadius
            segment3.radius = lineRadius
        }
    }
    
    @IBInspectable public var lineThickness: CGFloat = 4 {
        didSet {
            segment1.thickness = lineThickness
            segment2.thickness = lineThickness
            segment3.thickness = lineThickness
        }
    }
    
    
    public func setType(_ type: NovaLineType, animated: Bool) {
        if animated {
            UIView.animate(withDuration: animationDuration,
                                       delay: 0,
                                       usingSpringWithDamping: animationSpringDamping,
                                       initialSpringVelocity: animationSpringVelocity,
                                       options: [.beginFromCurrentState],
                                       animations:
                {
                    self.type = type
            }) { finished in
                
            }
            
        } else {
            self.type = type
        }
    }
    
    
    private let segment1 = DoubleLineSegment(frame: CGRect.zero)
    private let segment2 = DoubleLineSegment(frame: CGRect.zero)
    private let segment3 = DoubleLineSegment(frame: CGRect.zero)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initSegments()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initSegments()
    }
    
    fileprivate func initSegments() {
        isUserInteractionEnabled = false
        
        addSubview(segment1)
        addSubview(segment2)
        addSubview(segment3)
        
        segment1.isUserInteractionEnabled = false
        segment2.isUserInteractionEnabled = false
        segment3.isUserInteractionEnabled = false
        
        segment1.radius = lineRadius
        segment2.radius = lineRadius
        segment3.radius = lineRadius
        
        segment1.thickness = lineThickness
        segment2.thickness = lineThickness
        segment3.thickness = lineThickness
    }
    
    fileprivate var lineLength: CGFloat {
        return bounds.width * 0.5 - (inset + lineThickness * 0.5)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let inThick = (inset + lineThickness * 0.5)
        segment1.frame = bounds.insetBy(dx: inThick, dy: inThick)
        segment2.frame = bounds.insetBy(dx: inThick, dy: inThick)
        segment3.frame = bounds.insetBy(dx: inThick, dy: inThick)
        
        segment1.length = lineLength
        segment2.length = lineLength
        segment3.length = lineLength
        
        let type = self.type
        self.type = type
    }
    
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable public var typeAdapter: String? {
        willSet {
            if let newType = NovaLineType(rawValue: newValue ?? "") {
                type = newType
            }
        }
    }
}



private struct Angle {
    
    // Angle to have the 2 lines point towards
    var pointAt: CGFloat
    
    // The interior angle of the arrow
    var interiorAngle: CGFloat
    
    // To make things easy, construct with degrees
    init(_ pointDeg: CGFloat, _ angleDeg: CGFloat) {
        self.pointAt = pointDeg * (.pi / 180)
        self.interiorAngle = angleDeg * (.pi / 180)
    }
    
}



private class DoubleLineSegment: UIView {
    
    fileprivate var angle: Angle = Angle(90, 180) {
        didSet {
            rebuildFrames()
        }
    }
    
    fileprivate var length: CGFloat = 0 {
        didSet {
            recalculateAnchors()
            rebuildFrames()
        }
    }
    
    fileprivate var thickness: CGFloat = 0 {
        didSet {
            recalculateAnchors()
            rebuildFrames()
        }
    }
    
    fileprivate var radius: CGFloat = 0 {
        didSet {
            topPath.layer.cornerRadius = radius
            bottomPath.layer.cornerRadius = radius
        }
    }
    
    fileprivate var lineColor: UIColor = .white {
        didSet {
            topPath.backgroundColor = lineColor
            bottomPath.backgroundColor = lineColor
        }
    }
    
    // Our "paths" are nothing more than UIViews. Pretty simple.
    fileprivate let topPath = UIView(frame: CGRect.zero)
    fileprivate let bottomPath = UIView(frame: CGRect.zero)
    
    // The anchor points attach the two paths
    fileprivate func recalculateAnchors() {
        let anchorMod: CGFloat
        if length > 0 && thickness > 0 {
            anchorMod = (thickness * 0.5) / length
        } else {
            anchorMod = 0
        }
        // --------X
        topPath.layer.anchorPoint = CGPoint(x: 1 - anchorMod, y: 0.5)
        
        // X--------
        bottomPath.layer.anchorPoint = CGPoint(x: anchorMod, y: 0.5)
    }
    
    fileprivate func rebuildFrames() {
        // Reset the transform before rebuiling the frame
        topPath.transform = CGAffineTransform(rotationAngle: 0)
        bottomPath.transform = CGAffineTransform(rotationAngle: 0)
        
        // This sets up the paths like such:
        // -----top------X-----bottom------
        // ... where X is the anchor point for each path
        // top is pointing at 0 degrees and bottom is pointing at 180 degrees
        topPath.frame = CGRect(x: thickness * 0.5, y: bounds.midY - thickness * 0.5, width: length, height: thickness)
        bottomPath.frame = CGRect(x: bounds.midX - thickness * 0.5, y: bounds.midY - thickness * 0.5, width: length, height: thickness)
        
        // The final angles are based on the "Point At" angle adjusted by half the interior angle
        let topAngle = -angle.pointAt + angle.interiorAngle * 0.5
        let bottomAngle = .pi - angle.pointAt - angle.interiorAngle * 0.5
        
        topPath.transform = CGAffineTransform(rotationAngle: topAngle)
        bottomPath.transform = CGAffineTransform(rotationAngle: bottomAngle)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initPaths()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initPaths()
    }
    
    fileprivate func initPaths() {
        addSubview(bottomPath)
        addSubview(topPath)
        
        topPath.backgroundColor = lineColor
        bottomPath.backgroundColor = lineColor
    }
    
}





@IBDesignable open class NovaLineButton: UIButton {
    
    public let lineView = NovaLineView(frame: CGRect.zero)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lineView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(lineView)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        lineView.frame = bounds
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}



// Bridge Inspectable Properties for IB
extension NovaLineButton {
    
    public var type: NovaLineType {
        get {
            return lineView.type
        }
        set {
            lineView.type = newValue
        }
    }
    
    @IBInspectable public var lineColor: UIColor {
        get {
            return lineView.lineColor
        }
        set {
            lineView.lineColor = newValue
        }
    }
    
    @IBInspectable public var animationSpringDamping: CGFloat {
        get {
            return lineView.animationSpringDamping
        }
        set {
            lineView.animationSpringDamping = newValue
        }
    }
    
    @IBInspectable public var animationSpringVelocity: CGFloat {
        get {
            return lineView.animationSpringVelocity
        }
        set {
            lineView.animationSpringVelocity = newValue
        }
    }
    
    @IBInspectable public var animationDuration: Double {
        get {
            return lineView.animationDuration
        }
        set {
            lineView.animationDuration = newValue
        }
    }
    
    @IBInspectable public var triangleCompact: CGFloat {
        get {
            return lineView.triangleCompact
        }
        set {
            lineView.triangleCompact = newValue
        }
    }
    
    @IBInspectable public var inset: CGFloat {
        get {
            return lineView.inset
        }
        set {
            lineView.inset = newValue
        }
    }
    
    @IBInspectable public var lineRadius: CGFloat {
        get {
            return lineView.lineRadius
        }
        set {
            lineView.lineRadius = newValue
        }
    }
    
    @IBInspectable public var lineThickness: CGFloat {
        get {
            return lineView.lineThickness
        }
        set {
            lineView.lineThickness = newValue
        }
    }
    
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable public var typeAdapter: String? {
        get {
            return lineView.type.rawValue
        }
        set {
            if let newType = NovaLineType(rawValue: newValue ?? "") {
                lineView.type = newType
            }
        }
    }
    
}


