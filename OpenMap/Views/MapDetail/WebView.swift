//
//  WebView.swift
//  OpenMap
//
//  Created by Sam Patteson on 5/25/20.
//  Copyright © 2020 Asunder. All rights reserved.
//

import Foundation
import SwiftUI
import WebKit

// This view a wrapper for webview that adds state
struct WebView: UIViewRepresentable {
    
    // The states representing what wkwebview is currently doing.
    // We're using it to show/ hide an activity indicator
    enum WorkState: String {
        case initial
        case done
        case working
        case errorOccurred
    }
    
    var mapResult: MapResult
    @Binding var workState: WorkState
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        switch self.workState {
            case .initial:
                if let url = URL(string: self.mapResult.annotations.osm.url) {
                    uiView.load(URLRequest(url: url))
                }
            default:
                break
        }
    }
    
    func makeCoordinator() -> Coordinator {
          Coordinator(self)
      }

      class Coordinator: NSObject, WKNavigationDelegate {
          var parent: WebView

          func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            self.parent.workState = .working
          }

          func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
              self.parent.workState = .errorOccurred
          }

          func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
              self.parent.workState = .done
          }

          init(_ parent: WebView) {
              self.parent = parent
          }
      }
}
