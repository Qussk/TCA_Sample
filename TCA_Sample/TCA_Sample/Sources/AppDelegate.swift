//
//  AppDelegate.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import SwiftUI
import Combine
import ComposableArchitecture

@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?
    var cancellable = Set<AnyCancellable>()
}

extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
    
        resetRootViewController(rootVc: UIHostingController(rootView: SplashUI()))
        
        return true
    }

}

extension AppDelegate {
    func resetRootViewController(rootVc: UIViewController? = ViewController()) {
        self.window?.rootViewController = rootVc
        self.window?.makeKeyAndVisible()
    }
}
