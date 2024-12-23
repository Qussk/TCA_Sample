//
//  SplashFeature.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import Foundation
import ComposableArchitecture
import Combine
import SwiftUI

@Reducer
struct SplashFeature {
    struct State: Equatable {
        var appDelegate: AppDelegate?
    }
    
    enum Action: Equatable {
        case viewAppeared
        case goToMain
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .viewAppeared:
                guard let appDelegate = UIApplication.shared.appDelegate else { return .none }
                state.appDelegate = appDelegate
                return .run { await $0(.goToMain) }
            case .goToMain:
                guard let appDelegate = state.appDelegate else { return .none }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    appDelegate.resetRootViewController()
                    appDelegate.resetRootViewController(rootVc: UIHostingController(rootView: MainUI()))
                }
                return .none
            }
        }
    }
}
