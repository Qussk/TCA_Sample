//
//  Provider.swift
//  TCA_Sample
//
//  Created by kakaovx on 12/24/24.
//

import Foundation
import Moya
import UIKit

final class Provider<T: TargetType> {
    enum PrintOption {
        case disable
        case endPoint
        case endPointAndParameters
    }
    
    var printRequest: PrintOption = .endPointAndParameters
    var printResponse: PrintOption = .endPointAndParameters
    private var moyaProvider = MoyaProvider<T>()
}


// MARK: - Request
extension Provider {
    func request<E: Decodable>(_ target: T, entityType: E.Type, isIndicatorEnabled: Bool = false, completion: @escaping (Result<APIEntityResponse<E>, SessionError>) -> Void) {
        printRequestDescription(target: target)
        
        moyaProvider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    self.printResponseDescription(response: response)
                    var object = try self.jsonObject(data: response.data)
                    let data = try JSONSerialization.data(withJSONObject: object)
                    let apiResponse = try JSONDecoder().decode(APIEntityResponse<E>.self, from: data)
                    
                    completion(.success(apiResponse))
                }
                catch {
                    completion(.failure(.parsing))
                }
                
            case .failure(let error):
                completion(.failure(.parsing))
            }
        }
    }
    
    func asyncRequest<E: Decodable>(_ target: T, entityType: E.Type) async throws -> APIEntityResponse<E> {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target, entityType: entityType) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

// MARK: - Parsing

private extension Provider {
    func jsonObject(data: Data) throws -> [String: Any?] {
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dic = object as? [String: Any?]
            else { throw APIError.parsingResponse(body: String(data: data, encoding: .utf8)) }
            
            return dic
        }
        catch {
            throw error
        }
    }
}
// MARK: - Print

extension Provider {
    func printRequestDescription(target: T, withHeaders: Bool = false) {
        guard printRequest != .disable
        else { return }
        
        let endPoint = "\(target.method.rawValue) \(target.baseURL)/\(target.path)"
        var description = "[REQUEST | \(endPoint)]:"
        
        guard printRequest == .endPointAndParameters
        else {
            print(description)
            return
        }
        
        if withHeaders,
           let headers = target.headers,
           !headers.isEmpty,
           let data = try? JSONSerialization.data(withJSONObject: headers, options: [.prettyPrinted]),
           let string = String(data: data, encoding: .utf8){
            description += "\n\(string)"
        }
        
        if case .requestParameters(let parameters, _) = target.task,
           let data = try? JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted]),
           let string = String(data: data, encoding: .utf8) {
            description += "\n\(string)"
        }
        else {
            description += "\n\(target.task)"
        }
        
        print(description)
    }
    
    func printResponseDescription(response: Moya.Response) {
        guard printResponse != .disable,
              let request = response.request
        else { return }
        
        let data = response.data
        let endPoint = "\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")"
        let description = "[RESPONSE | \(endPoint)]:"
        
        guard printResponse == .endPointAndParameters
        else {
            print(description)
            return
        }
         
        if let object = try? JSONSerialization.jsonObject(with: data, options: []),
           let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
           let string = String(data: data, encoding: .utf8) {
            print("\(description)\n\(string)")
        }
        else {
            print("\(description) unknown.")
        }
    }
     
    func printUnknownResponse() {
        print("[RESPONSE]: unknown.")
    }
}
