//
//  APIResponse.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/24/24.
//

import Foundation


struct APIResponse: Decodable {
    
}

//struct APIEntityResponse<E: Decodable>: Decodable {
//    let total_count: Int
//    let incomplete_results: Bool
//    let items: [UserListItem]
//    
//    enum CodingKeys: String, CodingKey {
//        case total_count = "totalCount"
//        case incomplete_results = "incompleteResults"
//        case items
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.total_count = container.decodeString(forKey: .totalCount)
//        self.incomplete_results = container.decodeEnum(forKey: .incomplete_results)
//        self.items = container.decodeString(forKey: .items)
//    }
//}
