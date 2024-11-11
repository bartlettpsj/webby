//
//  ContentView.swift
//  webby
//
//  Created by Paul Bartlett on 11/9/24.
//

import SwiftUI
import WebKit

class ObservableViewModel: ObservableObject {
    @Published var logText: String = ""
}

struct ContentView: View {
    
    @State var urlToShow = ""
    @State var site = "https://direct.playstation.com/en-us/buy-consoles/playstation5-pro-console-30th-anniversary-limited-edition-bundle"
    
    var list = ["Started logging..."]
    @State var listText = "Hello World\n"
    
    @StateObject var viewModel: ObservableViewModel = ObservableViewModel()
       
    
    func doSomething(msg: String) {
                
        
        print("CHG \(Date())", msg)
//        viewModel.logText = "Hello World"

//        var list2 = list.map() { $0 }
//        list2.append("\(Date()) \(msg))")
//        list.append("sss");
//        listToText(list: list2)
        
//        list.append(msg)
        
//        var s = "";
//        list.forEach { v in
//            s = s + v + "\n";
//        }
//        s = s + "\(msg)\n";
        
//        let s = listText + "\(msg)\n"
        
//        DispatchQueue.main.async { listText = s }

        
//        DispatchQueue.main.async {

//            listText.append("\(msg)\n");
//            list.append("hello")
//            listText = listText + "\(msg)\n";
            
//        }
       
    }
        
//    func listToText(list: [String]) {
//        var s = "";
//        list.forEach { v in
//            s = s + v + "\n";
//        }
//        
//        DispatchQueue.main.async { listText = s }
//    }
            
    var body: some View {
        VStack {
            VStack {
                
                let a = Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                a
                
                TextField(text: $site, prompt: Text("Required")) {
                    Text("Site")
                }
                .textFieldStyle(.roundedBorder)
                
                Button("Open URL") {
                    urlToShow = site
                    // "https://direct.playstation.com/en-us/buy-consoles/playstation5-console-model-group-slim"
                }
            }
                      
            VStack {
                WebView(url: (URL(string:urlToShow) ?? URL(filePath: "")), doSomething: self.doSomething)
                    .padding(1.0)
                    .border(.black)
                
                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $listText, axis: .vertical)
                    .lineLimit(1...10)
                                
                 LogView(logText: "hello", viewModel: viewModel)
                    .onReceive(viewModel.logText.publisher, perform: { _ in print("test") } )
                        
                    
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//import SwiftUI
//import WebKit
//import MapKit
//
//
//struct ContentView: View {
//    @State private var textEntry1 = ""
//    @State private var textEntry2 = ""
//    @State private var location = CLLocationCoordinate2D()
//    @State private var locationName = ""
//    @State private var position = MapCameraPosition.camera(MapCamera.init(centerCoordinate: CLLocationCoordinate2D(latitude: -31.953512, longitude: 115.857048), distance: 100000))
//    @State var site = "https://direct.playstation.com/en-us/buy-consoles/playstation5-console-model-group-slim"
//
//
//    var body: some View {
//        VStack {
//            VStack {
//
//                HStack {
//                    Text("Choose Home Club")
//                    Spacer()
//                    Picker("Data", selection: $textEntry1) {
//                        Text("London").tag("London")
//                        Text("Perth").tag("Perth")
//                    }
//                }
//                HStack {
//                    Text("Chose Home Ballpark")
//                    Spacer()
//                    Picker("Data", selection: $textEntry2) {
//                        Text("London Mets").tag("London Mets")
//                        Text("Perth Heat").tag("Perth Heat")
//                    }
//                }
//                TextField(text: $site, prompt: Text("Required")) {
//                    Text("Site")
//                }
//                .textFieldStyle(.roundedBorder)
//
//                Button(action: {
//                    position = MapCameraPosition.camera(MapCamera.init(centerCoordinate: CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092), distance: 100000))
//                    location = CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
//                    locationName = "London"
//
//                }, label: {
//                    Text("Change location")
//                })
//
//
//            }
//            Spacer()
//            Map(position: $position) {
//                Marker("\(locationName)", systemImage: "mappin", coordinate: location)
//
//            }
//            .clipShape(RoundedRectangle(cornerRadius: 15))
//            .onAppear {
//                location = CLLocationCoordinate2D(latitude: -31.953512, longitude: 115.857048)
//                locationName = "Perth"
//            }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
