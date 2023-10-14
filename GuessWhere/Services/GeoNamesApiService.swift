//
//  GeoNamesApiService.swift
//  GuessWhere
//
//  Created by Rajeev R Menon on 10/13/23.
//

import Foundation
import Combine

class GeoNamesApiService {
    
    static var apiUrl = "https://api.3geonames.org/?randomland=US&json=1"
    
    static func getRandomLocation() -> AnyPublisher<GeoNamesApiResponse?, Error>  {
        guard let url = URL(string: apiUrl) else {
            fatalError("Wrong URL")
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({$0.data})
            .decode(type: GeoNamesApiResponse?.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


