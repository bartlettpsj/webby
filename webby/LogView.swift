//
//  LogView.swift
//  webby
//
//  Created by Paul Bartlett on 11/10/24.
//

import SwiftUI
import WebKit

struct LogView: View {
    
    @State var logText: String
    @ObservedObject var viewModel: ObservableViewModel
    
    func log(_ message: String) {
        logText.append("\(message)\n")
    }

    var body: some View {
        VStack {
            
            TextField("Logging", text: $viewModel.logText, axis: .vertical)
                .lineLimit(1...10)
                .onReceive(viewModel.logText.publisher, perform: { _ in print("test2") } )
        }
        
    }
    
}

#Preview {
    LogView(logText: "paul goodbye", viewModel: ObservableViewModel())
}
