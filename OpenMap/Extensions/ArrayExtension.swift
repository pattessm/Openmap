//
//  ArrayExtension.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/25/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import Foundation

// Just an easy way to remove dups.
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
