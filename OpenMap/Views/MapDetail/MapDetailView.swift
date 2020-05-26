//
//  MapDetailView.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/25/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import SwiftUI

// The whole detail view
struct MapDetailView: View {
    private let mapResult: MapResult
    private let searchTerm: String
    @State var workState = WebView.WorkState.initial
    
    init(mapResult: MapResult, searchTerm: String) {
      self.mapResult = mapResult
      self.searchTerm = searchTerm
    }

    var body: some View {
        ZStack {
            VStack {
                MapDetailHeaderView(mapResult: mapResult, searchTerm: searchTerm)
                WebView(mapResult: mapResult, workState: $workState)
                    .padding(.top, -100) // scootch up a bit
            }
            .padding(.top, -40) // scootch this up a bit, too
            
            if workState == .working || workState == .initial {
                ActivityIndicator(shouldAnimate: true)
            }
        }
    }
}

struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let osm = OSM(url: "https://www.openstreetmap.org/?mlat=43.66143&mlon=-92.93272#map=16/4.66143/-92.93272")
        let annotations = MapAnnotation(osm: osm, flag: "🇺🇸")
        return MapDetailView(mapResult: MapResult(annotations: annotations, shortDesc: "12 Fake st, Austin, Texas", components: MapComponents(type: "airport")), searchTerm: "Austin")
    }
}
