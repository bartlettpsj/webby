//
//  WebView.swift
//  webby
//
//  Created by Paul Bartlett on 11/9/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    class Coordinator: NSObject, WKNavigationDelegate {
            
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let url = webView.url?.absoluteString
            print("\(Date()) Done loading \(url.unsafelyUnwrapped)")
        }
    }
        
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.navigationDelegate = context.coordinator
        print("\(Date()) Start loading \(url.absoluteString)")
        uiView.load(request)
    }        
}
