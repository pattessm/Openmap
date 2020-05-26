//
//  ContentView.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/23/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel = MapViewModel(mapFetcher: MapFetcher())
 
    var body: some View {
        SearchListView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
