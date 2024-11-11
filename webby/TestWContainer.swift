//
//  TestView.swift
//  webby
//
//  Created by Paul Bartlett on 11/10/24.
//

import SwiftUI
@preconcurrency import WebKit
import UIKit
import Combine

class WebViewState : ObservableObject {
    @Published var url:URL?
    @Published var userSetUrl:URL?
    @Published var showLoader:Bool?
    @Published var estimatedProgress:Double?
}

struct TestWContainer: View {
    
    @StateObject var webViewState = WebViewState()
    
    var body: some View {
        ZStack {
            WebView2(webViewState : webViewState, userSetURL: webViewState.userSetUrl)
            
            if let estimatedProgress = webViewState.estimatedProgress {
                if estimatedProgress > 0 && estimatedProgress < 1 {
                    let _ = print("estimatedPogress: \(estimatedProgress)")
                    VStack(spacing:0) {
                        ProgressView(value: estimatedProgress, total: 1)
                            .frame(height: 3)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct WebView2: UIViewRepresentable {
    var webViewState : WebViewState
    var userSetURL: URL?
    
    fileprivate let defaultURL:URL = URL(string: "https://www.google.com")!
    
    class Coordinator: NSObject, WKNavigationDelegate {
    
        var parent: WebView2
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ webView: WebView2) {
            self.parent = webView
        }
        
        deinit {
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.webViewState.showLoader = false
        }
        
        func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
            
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.webViewState.showLoader = false
        }
        
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.webViewState.showLoader = true
        }
        
        // This function is essential for intercepting every navigation in the webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            dispatchPrecondition(condition: .onQueue(.main))
            print("Observing keyPath: \(String(describing: keyPath)). change: \(String(describing: change)). object: \(String(describing: object))")
            guard let wv = object as? WKWebView else { return }
            if keyPath == #keyPath(WKWebView.estimatedProgress) {
                print("O: progress: \(wv.estimatedProgress)")
                DispatchQueue.main.async {
                    self.parent.webViewState.estimatedProgress = wv.estimatedProgress
                }
            }
        }
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {

        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        print("setup: \(String(describing: webViewState.url))")
        load(url: userSetURL, in: webView)
    
        return webView
    }
    
    fileprivate func load(url:URL?, in webView:WKWebView) {
        
        if let url = url {
            print("load url....: \(url)")
            let req = URLRequest(url: url)
            webView.load(req)
        } else {
            print("load url google case...")
            let req = URLRequest(url: defaultURL)
            webView.load(req)
        }
        
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        print("updateUIView: \(String(describing: userSetURL))")
        load(url: userSetURL, in: webView)
    }
    
}

#Preview {
    TestWContainer()
}
