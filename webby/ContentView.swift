//
//  ContentView.swift
//  webby
//
//  Created by Paul Bartlett on 11/9/24.
//

import SwiftUI
import WebKit

struct ContentView: View {
    
    @State var urlToShow = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, click this to open")
            Button("Open Playstation Store") {
                urlToShow = "https://direct.playstation.com/en-us/buy-consoles/playstation5-pro-console"
            }
            WebView(url: (URL(string:urlToShow) ?? URL(filePath: "")))            .padding()
        }
    }
}

#Preview {
    ContentView()
}
