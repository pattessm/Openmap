//
//  MapDetailHeaderView.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/25/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import SwiftUI

// The composited map detail header view
struct MapDetailHeaderView: View {
    
    var mapResult: MapResult
    var searchTerm: String
    
    var body: some View {
        VStack {
            HStack {
                Text(searchTerm)
                .font(.largeTitle)
                .fontWeight(.semibold)
                Spacer()
                Text("Type: " + (mapResult.components.type ?? "Unknown").capitalized)
                    .font(.body)
                    .fontWeight(.light)
            }
            .padding(.leading)
            .padding(.trailing)
            
            FakeIconView()
                .padding(.top, -30)
            Spacer()
        }
    }
}

struct MapDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let osm = OSM(url: "https://www.openstreetmap.org/?mlat=43.66143&mlon=-92.93272#map=16/4.66143/-92.93272")
        let annotations = MapAnnotation(osm: osm, flag: "🇺🇸")
        let result = MapResult(annotations: annotations, shortDesc: "12 fake st, austin, texas", components: MapComponents(type: "Airport"))
        return MapDetailHeaderView(mapResult:  result, searchTerm: "Austin")
    }
}
