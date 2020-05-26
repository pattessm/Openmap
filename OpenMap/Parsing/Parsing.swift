//
//  Parsing.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/24/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, MapError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
