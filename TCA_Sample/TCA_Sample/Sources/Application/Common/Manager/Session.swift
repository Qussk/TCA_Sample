//
//  Session.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import Foundation
import ComposableArchitecture


enum SessionError: Error {
    case parsing
    case etc(message: String)

    var description: String {
        switch self {
        case .parsing: return "파싱 에러"
        case .etc(let message): return "\(message)"
        }
    }
}

final class Session {
    static let shared = Session()
    static let token = "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"
    var httpHeaders: [String: String] {
        var headers: [String: String] = [:]
        
        headers["Authorization"] = "Bearer \(Session.token)"
        return headers
    }

    private init() {
        setUp()
    }
}

// MARK: - Set Up

private extension Session {
    func setUp() {
        
    }
}
