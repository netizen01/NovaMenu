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
    public var buttonColor: UIColor = .white
    public var separatorColor: UIColor = UIColor(white: 1, alpha: 0.25)
    public var menuBorderColor: UIColor = .clear
    public var menuTitleColor: UIColor = .white
    
    public var animationOpenDuration: TimeInterval = 0.5
    public var animationCloseDuration: TimeInterval = 0.35
    public var animationSpringVelocity: CGFloat = 0.5
    public var animationSpringDamping: CGFloat = 0.7
    
    public var openStatusBarStyle: UIStatusBarStyle = .lightContent
    public var menuTitleFont: UIFont = UIFont(name: NovaMenuDefaultFontName, size: 18)!
    
    public init() {
        
    }
}

public protocol NovaMenuDataSource {
    func novaMenuNumberOfItems() -> Int
    func novaMenuItemAtIndex(_ index: Int) -> NovaMenuItem
    func novaMenuTitle() -> String?
}

public protocol NovaMenuDelegate {
    func novaMenuItemSelectedAtIndex(_ index: Int)
}

open class NovaMenuItem {
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


@objc open class NovaMenuViewController: UIViewController {
    
    open var dataSource: NovaMenuDataSource? {
        didSet {
            reloadMenuItems()
        }
    }
    open var delegate: NovaMenuDelegate?
    
    
    open fileprivate(set) var rootViewController: UIViewController!
    open var style: NovaMenuStyle = NovaMenuStyle() {
        didSet {
            applyStyle()
        }
    }
    
    fileprivate let menuView = NovaMenuView(frame: CGRect.zero)
    fileprivate var menuHeightConstaints: ConstraintGroup!
    fileprivate var menuVisibleConstaints: ConstraintGroup!
    
    fileprivate let dimmerView = UIView(frame: CGRect.zero)
    fileprivate var tapToClose: UITapGestureRecognizer!
    
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
    
    
    open var menuHidden: Bool = false {
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
    
    open func setMenuHidden(_ hidden: Bool, animated: Bool) {
        menuHidden = hidden
        if animated {
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
    open func setMenuOpen(_ open: Bool, animated: Bool) {
        expanded = open
        
        if animated {
//            UIView.animateWithDuration(0.25, animations: {
//                self.view.layoutIfNeeded()
//            })
        }
    }
    
    open func closeMenu(_ animated: Bool) {
        expanded = false
        if animated {
            
        }
    }
    
    open func openMenu(_ animated: Bool) {
        expanded = true
        if animated {
            
        }
    }
    
    open func reloadMenuItems() {
        menuView.tableView.reloadData()
        menuView.navigationBar.menuTitle.text = dataSource?.novaMenuTitle()
        
        // TODO: animate the expand button
    }

    open var contentView: UIView {
        return menuView.contentContainer
    }
    
    override open var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        return rootViewController.preferredInterfaceOrientationForPresentation
    }
    
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return rootViewController.supportedInterfaceOrientations
    }
    
    override open var shouldAutorotate : Bool {
        return rootViewController.shouldAutorotate
    }
    
    override open func loadView() {
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
        
        menuView.navigationBar.expandButton.addTarget(self, action: #selector(NovaMenuViewController.expandButtonHandler(_:)), for: .touchUpInside)

        menuView.tableView.dataSource = self
        menuView.tableView.delegate = self
        
        applyStyle()
        
    }
    
    fileprivate func applyStyle() {
        view.backgroundColor = style.backgroundColor
        
        menuView.backgroundColor = style.menuColor
        dimmerView.backgroundColor = style.dimmerColor
        
        menuView.navigationBar.expandButton.lineColor = style.buttonColor
        menuView.navigationBar.borderView.backgroundColor = style.menuBorderColor
        menuView.navigationBar.menuTitle.font = style.menuTitleFont
        menuView.navigationBar.menuTitle.textColor = style.menuTitleColor
        
        menuView.tableView.separatorColor = style.separatorColor
        menuView.tableView.separatorStyle = .singleLine
        
        menuView.tableView.setNeedsDisplay()
        menuView.tableView.reloadData()
    }
    
    func expandButtonHandler(_ sender: UIButton) {
        expanded = !expanded
    }
    
    override open var preferredStatusBarStyle : UIStatusBarStyle {
        return expanded ? style.openStatusBarStyle : rootViewController.preferredStatusBarStyle
    }
    
    fileprivate var expanded: Bool = false {
        didSet {
            if expanded && (dataSource?.novaMenuNumberOfItems() ?? 0) == 0 {
                expanded = false
                return
            }
            
            let animationDuration = expanded ? style.animationOpenDuration : style.animationCloseDuration
            let rootTransform = expanded ? CGAffineTransform(scaleX: style.rootScale, y: style.rootScale) : CGAffineTransform(scaleX: 1, y: 1)
            let rootAlpha: CGFloat = expanded ? style.rootFadeAlpha : 1
            let dimmerAlpha: CGFloat = expanded ? 1 : 0
            let contentAlpha: CGFloat = expanded ? 0 : 1
            let titleAlpha: CGFloat = expanded ? 1 : 0
            let contentDuration = expanded ? animationDuration * 0.25 : animationDuration * 0.5
            let contentDelay: TimeInterval = expanded ? 0 : animationDuration * 0.5
            let _: CGFloat = expanded ? 1 : 0
            let buttonLineType: NovaLineType = expanded ? .Close : .Menu2
            if expanded {
                reloadMenuItems()
            }
            
            let height = NovaMenuHeight + (expanded ? CGFloat(dataSource!.novaMenuNumberOfItems()) * style.itemHeight + style.menuPadding + style.menuBottomMargin : 0)
            menuHeightConstaints = constrain(view, menuView, replace: menuHeightConstaints) { view, menuView in
                menuView.height == height ~ 100
            }
            
            // Show / Hide the Content Container
            UIView.animate(withDuration: contentDuration, delay: contentDelay, options: [.beginFromCurrentState], animations: {
                self.menuView.contentContainer.alpha = contentAlpha
            }) { finished in
                
            }
            
            UIView.animate(withDuration: animationDuration,
                                       delay: 0,
                                       usingSpringWithDamping: style.animationSpringDamping,
                                       initialSpringVelocity: style.animationSpringVelocity,
                                       options: [.beginFromCurrentState, .allowAnimatedContent],
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
                    self.menuView.tableView.deselectRow(at: selected, animated: false)
                }
                if !self.expanded {
                    for (index, cell) in (self.menuView.tableView.visibleCells as! [NovaMenuTableViewCell]).enumerated() {
                        cell.reset(1 + CGFloat(index) * 0.5)
                    }
                    self.menuView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            }
            
            if expanded {
                for (index, cell) in (self.menuView.tableView.visibleCells as! [NovaMenuTableViewCell]).enumerated() {
                    cell.reset(1 + CGFloat(index) * 0.5)
                    cell.animateIn(animationDuration, delay: (animationDuration * 0.25) + TimeInterval(index) * 0.05)
                }
            }
            
        }
    }
    
}

extension NovaMenuViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.novaMenuNumberOfItems() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NovaMenuTableViewCell.Identifier, for: indexPath) as! NovaMenuTableViewCell
        cell.menuItem = dataSource!.novaMenuItemAtIndex(indexPath.row)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = NovaMenuTableHeaderView()
        header.gradientLayer.colors = [style.menuColor.cgColor, style.menuColor.withAlphaComponent(0).cgColor]
        return header
    }
    
}

extension NovaMenuViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return style.itemHeight
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return style.menuPadding
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        expanded = false
        if let menuItem = dataSource?.novaMenuItemAtIndex(indexPath.row) {
            menuItem.action?()
        }
        delegate?.novaMenuItemSelectedAtIndex(indexPath.row)
    }
}

class NovaMenuView: UIView {
    
    fileprivate let navigationBar = NovaMenuNavigationBar(frame: CGRect.zero)
    fileprivate let contentContainer = UIView(frame: CGRect.zero)
    fileprivate let tableView = UITableView(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(navigationBar)
        addSubview(tableView)
        addSubview(contentContainer)
        
        contentContainer.clipsToBounds = true
        contentContainer.backgroundColor = .clear
        
        tableView.backgroundColor = .clear
        tableView.clipsToBounds = true
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.scrollsToTop = false
        tableView.register(NovaMenuTableViewCell.self, forCellReuseIdentifier: NovaMenuTableViewCell.Identifier)
        
        tableView.cellLayoutMarginsFollowReadableWidth = false
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
    override class var layerClass : AnyClass {
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
                iconView.image = menuItem.image.withRenderingMode(.alwaysTemplate)
                titleLabel.textColor = menuItem.color
                tintColor = menuItem.color
            }
        }
    }
    
    var itemConstraints: ConstraintGroup = ConstraintGroup()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        titleLabel.textColor = .white
        tintColor = .white
        selectionStyle = .none
        
        iconView.alpha = 0
        titleLabel.alpha = 0
        
        iconView.contentMode = .scaleAspectFit
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        
        constrainItems(false)
    }
    
    fileprivate func constrainItems(_ active: Bool, distanceMod: CGFloat = 1) {
        itemConstraints = constrain(contentView, iconView, titleLabel, replace: itemConstraints) { contentView, iconView, titleLabel in
            iconView.centerY == contentView.centerY
            iconView.height == 20
            iconView.left == contentView.left + (active ? 20 : 70 * distanceMod)
            iconView.width == iconView.height
            
            titleLabel.centerY == contentView.centerY
            titleLabel.left == iconView.right + 20
            titleLabel.right == contentView.right - 20 ~ LayoutPriority(100)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        titleLabel.textColor = selected ? menuItem?.colorSelected : menuItem?.color
        tintColor = titleLabel.textColor
    }
    
    func animateIn(_ duration: TimeInterval, delay: TimeInterval) {
        constrainItems(true)
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5,  options: [.curveEaseOut], animations: {
            self.layoutIfNeeded()
            }) { (finished) in
        }
        UIView.animate(withDuration: duration * 0.5, delay: delay + duration * 0.1, options: [.curveEaseOut], animations: {
            self.iconView.alpha = 1
            self.titleLabel.alpha = 1
        }) { finished in
        }
    }
    
    func reset(_ distanceMod: CGFloat = 1) {
        constrainItems(false, distanceMod: distanceMod)
        layoutIfNeeded()
        iconView.alpha = 0
        titleLabel.alpha = 0
    }
}

class NovaMenuNavigationBar: UIView {
    
    fileprivate let borderView = UIView(frame: CGRect.zero)
    fileprivate let expandButton = NovaLineButton()
    fileprivate let menuTitle = UILabel(frame: CGRect.zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
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
