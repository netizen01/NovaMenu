//
//  NovaMenu
//
//  Inspired By: https://dribbble.com/shots/1977075-New-app-Menu-Interaction
//

import UIKit
import Cartography
import NovaLines


public struct NovaMenuStyle {
    public var itemHeight: CGFloat = 44
    public var topMargin: CGFloat = 100
    public var menuPadding: CGFloat = 10
    public var menuBottomMargin: CGFloat = 20
    public var rootScale: CGFloat = 0.92
    public var rootFadeAlpha: CGFloat = 0.4
    
    public var backgroundColor: UIColor = UIColor(red:0.27, green:0.32, blue:0.35, alpha:1.00)
    public var menuColor: UIColor = UIColor(red:0.27, green:0.32, blue:0.35, alpha:1.00)
    public var dimmerColor: UIColor = UIColor(red:0.27, green:0.32, blue:0.35, alpha:0.75)
    public var buttonColor: UIColor = .whiteColor()
    public var separatorColor: UIColor = UIColor(white: 1, alpha: 0.25)
    public var menuBorderColor: UIColor = .clearColor()
    public var menuTitleColor: UIColor = .whiteColor()
    
    public var animationOpenDuration: NSTimeInterval = 0.5
    public var animationCloseDuration: NSTimeInterval = 0.35
    public var animationSpringVelocity: CGFloat = 0.5
    public var animationSpringDamping: CGFloat = 0.7
    
    public var openStatusBarStyle: UIStatusBarStyle = .LightContent
    public var menuTitleFont: UIFont = UIFont(name: NovaMenuDefaultFontName, size: 18)!
    
    public init() {
        
    }
}

public protocol NovaMenuDataSource {
    func novaMenuNumberOfItems() -> Int
    func novaMenuItemAtIndex(index: Int) -> NovaMenuItem
    func novaMenuTitle() -> String?
}

public protocol NovaMenuDelegate {
    func novaMenuItemSelectedAtIndex(index: Int)
}

public class NovaMenuItem {
    var title: String
    var font: UIFont
    var image: UIImage
    var color: UIColor
    var colorSelected: UIColor
    var action: (() -> ())?
    
    public init(title: String, image: UIImage, color: UIColor, colorSelected: UIColor, font: UIFont = UIFont(name: NovaMenuDefaultFontName, size: 20)!, action: (() -> ())? = nil) {
        self.title = title
        self.image = image
        self.color = color
        self.colorSelected = colorSelected
        self.font = font
        self.action = action
    }
    
}







// Changing this will require redoing the Expand Button Animation ... so don't.
private let NovaMenuHeight: CGFloat = 52
private let NovaMenuDefaultFontName = "AvenirNextCondensed-DemiBold"


@objc public class NovaMenuViewController: UIViewController {
    
    public var dataSource: NovaMenuDataSource? {
        didSet {
            reloadMenuItems()
        }
    }
    public var delegate: NovaMenuDelegate?
    
    
    public private(set) var rootViewController: UIViewController!
    public var style: NovaMenuStyle = NovaMenuStyle() {
        didSet {
            applyStyle()
        }
    }
    
    private let menuView = NovaMenuView(frame: CGRect.zero)
    private var menuHeightConstaints: ConstraintGroup!
    private var menuVisibleConstaints: ConstraintGroup!
    
    private let dimmerView = UIView(frame: CGRect.zero)
    private var tapToClose: UITapGestureRecognizer!
    
    public init(rootViewController: UIViewController, style: NovaMenuStyle? = nil) {
        super.init(nibName: nil, bundle: nil)
        if let style = style {
            self.style = style
        }
        self.rootViewController = rootViewController
        addChildViewController(rootViewController)
        
        tapToClose = UITapGestureRecognizer(target: self, action: #selector(NovaMenuViewController.closeMenu))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    public var menuHidden: Bool = false {
        didSet {
            if menuHidden {
                menuVisibleConstaints = constrain(view, rootViewController.view, menuView, replace: menuVisibleConstaints) { view, rootView, menuView in
                    menuView.bottom == view.bottom + NovaMenuHeight
                    rootView.bottom == view.bottom
                }
            } else {
                menuVisibleConstaints = constrain(view, rootViewController.view, menuView, replace: menuVisibleConstaints) { view, rootView, menuView in
                    menuView.bottom == view.bottom
                    rootView.bottom == view.bottom - NovaMenuHeight
                }
            }
        }
    }
    
    public func setMenuHidden(hidden: Bool, animated: Bool) {
        menuHidden = hidden
        if animated {
            UIView.animateWithDuration(0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    public func setMenuOpen(open: Bool, animated: Bool) {
        expanded = open
        
        if animated {
//            UIView.animateWithDuration(0.25, animations: {
//                self.view.layoutIfNeeded()
//            })
        }
    }
    
    public func closeMenu(animated: Bool) {
        expanded = false
        if animated {
            
        }
    }
    
    public func openMenu(animated: Bool) {
        expanded = true
        if animated {
            
        }
    }
    
    public func reloadMenuItems() {
        menuView.tableView.reloadData()
        menuView.navigationBar.menuTitle.text = dataSource?.novaMenuTitle()
        
        // TODO: animate the expand button
    }

    public var contentView: UIView {
        return menuView.contentContainer
    }
    
    override public func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return rootViewController.preferredInterfaceOrientationForPresentation()
    }
    
    override public func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return rootViewController.supportedInterfaceOrientations()
    }
    
    override public func shouldAutorotate() -> Bool {
        return rootViewController.shouldAutorotate()
    }
    
    override public func loadView() {
        super.loadView()
        
        
        view.addSubview(rootViewController.view)
        view.addSubview(dimmerView)
        view.addSubview(menuView)
        
        dimmerView.alpha = 0
        dimmerView.addGestureRecognizer(tapToClose)
        
        constrain(view, rootViewController.view) { view, rootView in
            rootView.top == view.top
            rootView.left == view.left
            rootView.right == view.right
        }
        
        constrain(view, menuView, dimmerView) { view, menuView, dimmerView in
            menuView.left == view.left
            menuView.right == view.right
            
            dimmerView.left == view.left
            dimmerView.right == view.right
            dimmerView.top == view.top
            dimmerView.bottom == menuView.top
            dimmerView.height >= style.topMargin
        }
        
        menuVisibleConstaints = constrain(view, rootViewController.view, menuView) { view, rootView, menuView in
            menuView.bottom == view.bottom
            rootView.bottom == view.bottom - NovaMenuHeight
        }
        
        menuHeightConstaints = constrain(view, menuView) { view, menuView in
            menuView.height == NovaMenuHeight ~ 100
        }
        
        menuView.navigationBar.expandButton.addTarget(self, action: #selector(NovaMenuViewController.expandButtonHandler(_:)), forControlEvents: .TouchUpInside)

        
        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        
        applyStyle()
        
    }
    
    private func applyStyle() {
        view.backgroundColor = style.backgroundColor
        
        menuView.backgroundColor = style.menuColor
        dimmerView.backgroundColor = style.dimmerColor
        
        menuView.navigationBar.expandButton.lineColor = style.buttonColor
        menuView.navigationBar.borderView.backgroundColor = style.menuBorderColor
        menuView.navigationBar.menuTitle.font = style.menuTitleFont
        menuView.navigationBar.menuTitle.textColor = style.menuTitleColor
        
        menuView.tableView.separatorColor = style.separatorColor
        
        menuView.tableView.setNeedsDisplay()
        menuView.tableView.reloadData()
    }
    
    func expandButtonHandler(sender: UIButton) {
        expanded = !expanded
    }
    
    override public func preferredStatusBarStyle() -> UIStatusBarStyle {
        return expanded ? style.openStatusBarStyle : rootViewController.preferredStatusBarStyle()
    }
    
    private var expanded: Bool = false {
        didSet {
            if expanded && (dataSource?.novaMenuNumberOfItems() ?? 0) == 0 {
                expanded = false
                return
            }
            
            let animationDuration = expanded ? style.animationOpenDuration : style.animationCloseDuration
            let rootTransform = expanded ? CGAffineTransformMakeScale(style.rootScale, style.rootScale) : CGAffineTransformMakeScale(1, 1)
            let rootAlpha: CGFloat = expanded ? style.rootFadeAlpha : 1
            let dimmerAlpha: CGFloat = expanded ? 1 : 0
            let contentAlpha: CGFloat = expanded ? 0 : 1
            let titleAlpha: CGFloat = expanded ? 1 : 0
            let contentDuration = expanded ? animationDuration * 0.25 : animationDuration * 0.5
            let contentDelay: NSTimeInterval = expanded ? 0 : animationDuration * 0.5
            let drawState: CGFloat = expanded ? 1 : 0
            let buttonLineType: NovaLineType = expanded ? .Close : .Menu2
            if expanded {
                reloadMenuItems()
            }
            
            let height = NovaMenuHeight + (expanded ? CGFloat(dataSource!.novaMenuNumberOfItems()) * style.itemHeight + style.menuPadding + style.menuBottomMargin : 0)
            menuHeightConstaints = constrain(view, menuView, replace: menuHeightConstaints) { view, menuView in
                menuView.height == height ~ 100
            }
            
            // Show / Hide the Content Container
            UIView.animateWithDuration(contentDuration, delay: contentDelay, options: [.BeginFromCurrentState], animations: {
                self.menuView.contentContainer.alpha = contentAlpha
            }) { finished in
                
            }
            
            UIView.animateWithDuration(animationDuration,
                                       delay: 0,
                                       usingSpringWithDamping: style.animationSpringDamping,
                                       initialSpringVelocity: style.animationSpringVelocity,
                                       options: [.CurveEaseInOut, .BeginFromCurrentState, .AllowAnimatedContent],
                                       animations:
                {
                    self.view.layoutIfNeeded()
                    self.setNeedsStatusBarAppearanceUpdate()
                    
                    self.rootViewController.view.transform = rootTransform
                    self.rootViewController.view.alpha = rootAlpha
                    self.dimmerView.alpha = dimmerAlpha
                    self.menuView.navigationBar.menuTitle.alpha = titleAlpha
                    
                    self.menuView.navigationBar.expandButton.type = buttonLineType
                }
            ) { finished in
                if let selected = self.menuView.tableView.indexPathForSelectedRow {
                    self.menuView.tableView.deselectRowAtIndexPath(selected, animated: false)
                }
                if !self.expanded {
                    for (index, cell) in (self.menuView.tableView.visibleCells as! [NovaMenuTableViewCell]).enumerate() {
                        cell.reset(1 + CGFloat(index) * 0.5)
                    }
                    self.menuView.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: false)
                }
            }
            
            if expanded {
                for (index, cell) in (self.menuView.tableView.visibleCells as! [NovaMenuTableViewCell]).enumerate() {
                    cell.reset(1 + CGFloat(index) * 0.5)
                    cell.animateIn(animationDuration, delay: (animationDuration * 0.25) + NSTimeInterval(index) * 0.05)
                }
            }
            
        }
    }
    
}

extension NovaMenuViewController: UITableViewDataSource {
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.novaMenuNumberOfItems() ?? 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NovaMenuTableViewCell.Identifier, forIndexPath: indexPath) as! NovaMenuTableViewCell
        cell.menuItem = dataSource!.novaMenuItemAtIndex(indexPath.row)
        return cell
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = NovaMenuTableHeaderView()
        header.gradientLayer.colors = [style.menuColor.CGColor, style.menuColor.colorWithAlphaComponent(0).CGColor]
        return header
    }
    
}

extension NovaMenuViewController: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return style.itemHeight
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return style.menuPadding
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        expanded = false
        if let menuItem = dataSource?.novaMenuItemAtIndex(indexPath.row) {
            menuItem.action?()
        }
        delegate?.novaMenuItemSelectedAtIndex(indexPath.row)
    }
}

class NovaMenuView: UIView {
    
    private let navigationBar = NovaMenuNavigationBar(frame: CGRect.zero)
    private let contentContainer = UIView(frame: CGRect.zero)
    private let tableView = UITableView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(navigationBar)
        addSubview(tableView)
        addSubview(contentContainer)
        
        contentContainer.clipsToBounds = true
        contentContainer.backgroundColor = .clearColor()
        
        tableView.backgroundColor = .clearColor()
        tableView.clipsToBounds = true
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.registerClass(NovaMenuTableViewCell.self, forCellReuseIdentifier: NovaMenuTableViewCell.Identifier)
        
        constrain(navigationBar, tableView, self) { navigationBar, tableView, view in
            navigationBar.left == view.left
            navigationBar.right == view.right
            navigationBar.top == view.top
            navigationBar.height == NovaMenuHeight
            
            tableView.top == navigationBar.bottom
            tableView.left == view.left
            tableView.right == view.right
            tableView.bottom == view.bottom
        }
        
        constrain(navigationBar, contentContainer, self) { navigationBar, contentContainer, view in
            contentContainer.height == navigationBar.height
            contentContainer.left == view.left + NovaMenuHeight
            contentContainer.right == view.right
            contentContainer.bottom == view.bottom
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NovaMenuTableHeaderView: UIView {
    override class func layerClass() -> AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
}


class NovaMenuTableViewCell: UITableViewCell {
    static let Identifier = "NovaMenuTableViewCell"
    let iconView = UIImageView(frame: CGRect.zero)
    let titleLabel = UILabel(frame: CGRect.zero)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var menuItem: NovaMenuItem? {
        didSet {
            if let menuItem = menuItem {
                titleLabel.text = menuItem.title
                titleLabel.font = menuItem.font
                iconView.image = menuItem.image.imageWithRenderingMode(.AlwaysTemplate)
                titleLabel.textColor = menuItem.color
                tintColor = menuItem.color
            }
        }
    }
    
    var itemConstraints: ConstraintGroup = ConstraintGroup()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clearColor()
        titleLabel.textColor = .whiteColor()
        tintColor = .whiteColor()
        selectionStyle = .None
        
        iconView.alpha = 0
        titleLabel.alpha = 0
        
        iconView.contentMode = .ScaleAspectFit
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        
        constrainItems(false)
    }
    
    private func constrainItems(active: Bool, distanceMod: CGFloat = 1) {
        itemConstraints = constrain(contentView, iconView, titleLabel, replace: itemConstraints) { contentView, iconView, titleLabel in
            iconView.centerY == contentView.centerY
            iconView.height == 20
            iconView.left == contentView.left + (active ? 20 : 70 * distanceMod)
            iconView.width == iconView.height
            
            titleLabel.centerY == contentView.centerY
            titleLabel.left == iconView.right + 20
            titleLabel.right == contentView.right - 20
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        titleLabel.textColor = selected ? menuItem?.colorSelected : menuItem?.color
        tintColor = titleLabel.textColor
    }
    
    func animateIn(duration: NSTimeInterval, delay: NSTimeInterval) {
        
        constrainItems(true)
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5,  options: [.CurveEaseOut], animations: {
            self.layoutIfNeeded()
            }) { (finished) in
        }
        UIView.animateWithDuration(duration * 0.5, delay: delay + duration * 0.1, options: [.CurveEaseOut], animations: {
            self.iconView.alpha = 1
            self.titleLabel.alpha = 1
        }) { (finished) in
        }
    }
    
    func reset(distanceMod: CGFloat = 1) {
        constrainItems(false, distanceMod: distanceMod)
        layoutIfNeeded()
        iconView.alpha = 0
        titleLabel.alpha = 0
    }
}

class NovaMenuNavigationBar: UIView {
    
    private let borderView = UIView(frame: CGRect.zero)
    private let expandButton = NovaLineButton()
    private let menuTitle = UILabel(frame: CGRect.zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clearColor()
        
        addSubview(expandButton)
        addSubview(menuTitle)
        addSubview(borderView)
        
        expandButton.type = .Menu2
        expandButton.inset = 8
        expandButton.lineRadius = 1
        expandButton.lineThickness = 2
        
        constrain(borderView, expandButton, menuTitle, self) { borderView, expandButton, menuTitle, view in
            borderView.left == view.left
            borderView.top == view.top
            borderView.right == view.right
            borderView.height == 1
            
            expandButton.left == view.left
            expandButton.top == view.top
            expandButton.bottom == view.bottom
            expandButton.width == expandButton.height
            
            menuTitle.left == expandButton.right + 4
            menuTitle.top == view.top
            menuTitle.bottom == view.bottom
            menuTitle.right == view.right - 8
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
