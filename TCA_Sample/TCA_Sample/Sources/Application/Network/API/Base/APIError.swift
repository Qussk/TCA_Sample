//
//  APIError.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/24/24.
//

import Foundation

enum APIError: Error, Decodable {
    case unowned
    case parsingResponse(body: String?)
    case emptyResultData
    
    var desc: String {
        switch self {
        case .parsingResponse(let body):
            return "error: \(self.localizedDescription)\n body: \(body ?? "")"
        default:
            return self.localizedDescription
        }
    }
}
