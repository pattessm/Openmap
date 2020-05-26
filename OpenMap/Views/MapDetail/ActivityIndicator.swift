//
//  ActivityIndicator.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/25/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import SwiftUI

// A wrapper of an activity indicator 
struct ActivityIndicator: UIViewRepresentable {
    var shouldAnimate: Bool

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = UIColor(red: 101.0 / 255.0, green: 195.0 / 255.0, blue: 102 / 255.0, alpha: 0.7)
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(shouldAnimate: true)
    }
}
