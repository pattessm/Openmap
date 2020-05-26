//
//  MapError.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/24/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import Foundation

enum MapError: Error {
  case parsing(description: String)
  case network(description: String)
}
