//
//  MapFetcher.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/24/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import Foundation
import Combine

protocol MapFetchable {
  func mapData(forTerm term: String) -> AnyPublisher<MapDataResponse, MapError>
}

class MapFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
}

// Here we're sinking to the Open Cage api
extension MapFetcher: MapFetchable {
    func mapData(forTerm term: String) -> AnyPublisher<MapDataResponse, MapError> {
        return map(with: makeMapSearchComponents(withTerm: term))
    }
    
    private func map<T>(with components: URLComponents) -> AnyPublisher<T, MapError> where T: Decodable {
        guard let url = components.url else {
          let error = MapError.network(description: "Couldn't create URL")
          return Fail(error: error).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap() { pair in
            decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
}


private extension MapFetcher {
    struct OpenCageAPI {
      static let scheme = "https"
      static let host = "api.opencagedata.com"
      static let path = "/geocode/v1/json"
      static let key = "ef70738393d849658559b301dcbba8ef"
    }
    
    func makeMapSearchComponents(withTerm term: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenCageAPI.scheme
        components.host = OpenCageAPI.host
        components.path = OpenCageAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "key", value: OpenCageAPI.key),
            URLQueryItem(name: "q", value: term)
        ]
        return components
    }
}
