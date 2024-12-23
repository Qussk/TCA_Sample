//
//  UIApplication+.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import UIKit


extension UIApplication {
    var screen: UIScreen? {
        return (self.connectedScenes.first as? UIWindowScene)?.screen
    }
}

extension UIApplication {
    var window: UIWindow? {
        return UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last
    }
    
    var appDelegate: AppDelegate? {
        return self.delegate as? AppDelegate
    }
    
    var rootViewController: UIViewController? {
        return UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last?.rootViewController
    }
    
    static func topmostViewController(rootViewController: UIViewController? = nil) -> UIViewController? {
        let root: UIViewController?
        
        if let rootViewController {
            root = rootViewController
        }
        else {
            root = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last?.rootViewController
        }
        
        if let nc = root as? UINavigationController {
            return topmostViewController(rootViewController: nc.visibleViewController)
        }
        
        if let tc = root as? UITabBarController {
            return topmostViewController(rootViewController: tc.selectedViewController)
        }
        
        if let presented = root?.presentedViewController {
            return topmostViewController(rootViewController: presented)
        }
        
        return root
    }
}

