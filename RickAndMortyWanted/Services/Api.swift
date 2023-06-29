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
    
    static func request<T: Codable>(endpoint: Endpoints, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let urlEndpoint = Constants.baseUrl.appending(endpoint.rawValue)
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
