//
//  MainFeature.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/24/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI
import Combine


@Reducer
struct SearchFeature {
    enum SearchTab: Int, Equatable, CaseIterable {
        case search = 0
        case favorit
    }
    
    struct State: Equatable {
        var searchTab: SearchTab = .search
        var searchTitle = ["조회", "즐겨찾기"]
        var isSelectTab: Int = 0
        var query: String = "q"
        var page: Int = 1
        @BindingState var latestQuery: String = ""
    }
    
    
    enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case viewAppeared
        case tabSelected(Int)
        case textFieldInput(String, Int)
        case requestUserList([UserListItem]?)
    }
    
    @Dependency(\.searchListAPI) var searchListApi

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .viewAppeared:
                let query = state.query
                let page = state.page
                return .run { send in
                    do {
                        await send(.textFieldInput(query, page))
                        try await send(.requestUserList(self.searchListApi.fetch(query, page)))
                    } catch {
                        print("Error: \(error)")
                    }

                }
            case .tabSelected(let index):
                state.isSelectTab = index
                switch index {
                case 0 : state.searchTab = .search
                case 1 : state.searchTab = .favorit
                default:
                    state.searchTab = .search
                }
            return .none
            case let .textFieldInput(quety, page):
                return .none
            case .requestUserList(let response):
                return .none
            default :
                return .none
            }
        }
    }
}



// MARK: - Dependency

struct SearchListAPI {
    var fetch: (String, Int) async throws -> [UserListItem]
}

extension SearchListAPI: DependencyKey {
    static let liveValue = Self(
        fetch: { (query, page) in
            let response = try await Provider<UserListTarget>().asyncRequest(.mainSearch(query, page), entityType: [UserListItem].self)
            return response.entity
        })
}


// MARK: - DependencyValues

extension DependencyValues {
    var searchListAPI: SearchListAPI {
        get { self[SearchListAPI.self] }
        set { self[SearchListAPI.self] = newValue }
    }
}
