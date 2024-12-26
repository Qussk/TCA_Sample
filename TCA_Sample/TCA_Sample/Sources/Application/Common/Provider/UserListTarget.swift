//
//  UserlistTarget.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import Foundation
import Moya


enum UserListTarget {
    case mainSearch(String, Int)
}

extension UserListTarget: TargetType {
    var baseURL: URL {
        switch self {
        case .mainSearch:
            return URL(string: ServiceURL.base)!
        }
    }
    
    var path: String {
        switch self {
        case .mainSearch: return "/search/users"
        }
    }
    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        
        switch self {
        case let .mainSearch(query, page):
            parameters["q"] = query
            parameters["page"] = page
        }
        return parameters
    }
    
    var headers: [String: String]? {
        switch self {
        case .mainSearch:
            return Session.shared.httpHeaders
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .mainSearch: return .get
        }
    }
    
    var task: Moya.Task {
        return .requestParameters(parameters: self.parameters ?? [:], encoding: URLEncoding.default)
    }

}
