//
//  MapViewModel.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/24/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published var dataSource: [MapResult] = []
    @Published var mapError: MapError? = nil

    private var disposables = Set<AnyCancellable>()
    private let mapFetcher: MapFetchable
    
    init(mapFetcher: MapFetchable,
         scheduler: DispatchQueue = DispatchQueue(label: "MapViewModel")) {
        self.mapFetcher = mapFetcher
        
        $searchTerm
        .dropFirst(1) // Don't send the first (nil) value after sinking
        .removeDuplicates()
        .debounce(for: .seconds(0.5), scheduler: scheduler) // debounce the input for half second.
        .sink(receiveValue: fetchMap(for:))
        .store(in: &disposables)
    }
    
    func fetchMap(for term: String) {
        mapFetcher.mapData(forTerm: term)
            .receive(on: DispatchQueue.main) // when we get the info back from the api, use main thread.
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                    case .failure (let error):
                        self.dataSource = []
                        self.mapError = error
                    case .finished:
                        break
                    }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                
                self.dataSource = value.results.removingDuplicates()
                self.mapError = nil
            })
        .store(in: &disposables)
    }
}
