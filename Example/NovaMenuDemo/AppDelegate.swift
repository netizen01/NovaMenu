//
//  AppDelegate.swift
//  NovaMenuDemo
//

import UIKit
import NovaMenu

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        let menuViewController = NovaMenuViewController(rootViewController: rootViewController)
        
        menuViewController.dataSource = self
        menuViewController.delegate = self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = menuViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

extension AppDelegate: NovaMenuDataSource {
    
    func novaMenuNumberOfItems() -> Int {
        return 3
    }
    func novaMenuItemAtIndex(_ index: Int) -> NovaMenuItem {
        return NovaMenuItem(title: "Menu Item", image: UIImage(named:"whale")!, color: .white, colorSelected: .lightGray, font: .systemFont(ofSize: 14), action: {
            print("Menu Item Action")
        })
    }
    func novaMenuTitle() -> String? {
        return "Nova Menu Title"
    }
    
}

extension AppDelegate: NovaMenuDelegate {
    
    func novaMenuItemSelectedAtIndex(_ index: Int) {
        print(index)
    }
    
}
