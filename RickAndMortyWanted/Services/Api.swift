//
//  Call.swift
//  RickAndMortyWanted
//
//  Created by Iago on 29/06/23.
//

import Foundation

final class Api {
    
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api/"
    }
    
    static func request<T: Codable>(endpoint: Endpoints, type: T.Type, queryParameters: [URLQueryItem] = [], pathParam: String = "", completion: @escaping (Result<T, Error>) -> Void) {
        
        var urlEndpoint = Constants.baseUrl.appending(endpoint.rawValue)
        
        if(!pathParam.isEmpty){
            urlEndpoint.append("/" + pathParam)
        }
        
        if !queryParameters.isEmpty {
            urlEndpoint += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            urlEndpoint += argumentString
        }
        
        guard let url = URL(string: urlEndpoint) else {
            let error = NSError(domain: urlEndpoint, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: urlEndpoint, code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let dataDecoded = try JSONDecoder().decode(type, from: data)
                completion(.success(dataDecoded))
                return
            } catch {
                let error = NSError(domain: urlEndpoint, code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
            }
        }.resume()
    }
}
