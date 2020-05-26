//
//  FakeIconView.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/25/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import SwiftUI

// This case just an icon that looks neat.
struct FakeIconView: View {
    var body: some View {
        ZStack {
            ForEach(0..<3) { i in
                Rectangle()
                    .fill(LinearGradient(gradient: .init(colors: [Color(red: 0.0, green: 1.0, blue: 0.0, opacity: 0.7), Color(red: 0.0, green: 0.0, blue: 1.0, opacity: 0.7)]),
                                         startPoint: .init(x: 0, y: 1),
                                         endPoint: .init(x: 1, y: 0)))
                    .frame(width: 100, height: 100, alignment: .center)
                    .rotationEffect(.degrees(Double(i) * 60.0))
            }
            Image(systemName: "globe")
                .resizable()
                .opacity(0.5)
                .frame(width: 70, height: 70, alignment: .center)
        }
        .frame(width: 150, height: 150, alignment: .center)
        .padding(.top, 0)
    }
}

struct FakeIconView_Previews: PreviewProvider {
    static var previews: some View {
        FakeIconView()
    }
}
