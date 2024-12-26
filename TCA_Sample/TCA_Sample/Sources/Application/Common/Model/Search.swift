//
//  Main.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/23/24.
//

import Foundation


//base
public struct APIEntityResponse<E: Decodable>: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let entity: [UserListItem]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case entity = "items"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalCount = try container.decode(Int.self, forKey: .totalCount)
        self.incompleteResults = try container.decode(Bool.self, forKey: .incompleteResults)
        self.entity = try container.decode([UserListItem].self, forKey: .entity)
//        self.entity = try? container.decode([E].self, forKey: .entity)
        
//        if E.self is String.Type {
//            self.entity = try container.decode(String.self,forKey: .entity) as? E
//        }
//        else if E.self is Int.Type {
//            self.entity =  try container.decode(Int.self,forKey: .entity) as? E
//        }
//        else if E.self is Bool.Type {
//            self.entity = try container.decode(Bool.self,forKey: .entity) as? E
//        }
//        else if E.self is Double.Type {
//            self.entity = try container.decode(Double.self,forKey: .entity) as? E
//        }
//        else {
//            self.entity = try? container.decode(E.self, forKey: .entity)
//        }

    }
}
//유저 리스트
public struct UserListItem: Decodable, Hashable {
    let id: Int
    let login: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case imageURL = "avatar_url"
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.login = try container.decode(String.self, forKey: .login)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
    
    public init(id: Int, login: String, imageURL: String) {
        self.id = id
        self.login = login
        self.imageURL = imageURL
    }
}
