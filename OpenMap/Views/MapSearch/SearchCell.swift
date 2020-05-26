//
//  SearchCell.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/25/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import SwiftUI

struct SearchCell: View {
    // A "cell" that shows the user some pertinient information
    private let mapResult: MapResult
    
    init(mapResult: MapResult) {
      self.mapResult = mapResult
    }
    
    var body: some View {
        HStack {
            Text(self.mapResult.shortDesc)
                .font(.caption)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)

            Spacer()
            Text(self.mapResult.annotations.flag)
                .font(.system(size: 30))
        }
        .padding()
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        let osm = OSM(url: "https://www.openstreetmap.org/?mlat=43.66143&mlon=-92.93272#map=16/4.66143/-92.93272")
        let annotations = MapAnnotation(osm: osm, flag: "🇺🇸")
        return SearchCell(mapResult: MapResult(annotations: annotations, shortDesc: "12 fake st, austin, texas", components: MapComponents(type: "airport")))
    }
}
