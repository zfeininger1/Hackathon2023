//
//  ContentView.swift
//  TestDemo
//
//  Created by Zachary Feininger on 2/3/23.
//

import SwiftUI
import UIKit
import MapKit
import CoreLocation
import Combine
import Contacts
import Foundation
import CoreML


struct ContentView: View {
    @State private var showText = false
    @State private var showTextHigh = false
    @State private var showTextLow = false
    var body: some View {
        NavigationView {
            ZStack {
                Image("IMG_002")
                        .resizable()
                        .scaledToFill()
                        .frame(width:750, height:500)
                VStack(spacing: 5) {
                    Text("Welcome")
                        .fontWeight(.bold)
                        .font(.system(size: 60))
                        .opacity(showText ? 1 : 0)
                        .frame(width: 300, height:200,  alignment: .top)
                        .animation(Animation.linear(duration: 1).delay(0.5))
                        .onAppear() {
                            self.showText = true
                        }
                    HStack {
                        NavigationLink(destination: shareDataPage()) {
                            Rectangle()
                                .fill(Color.green.opacity(0.75))
                                .cornerRadius(15)
                                .frame(width: 200, height: 70)
                                .overlay(
                                    Text("Share Data")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .font(.title)
                                        .opacity(self.showTextHigh ? 1 : 0)
                                        .animation(Animation.linear(duration: 1).delay(1.5))
                                        .onAppear() {
                                            self.showTextHigh = true
                                        }
                                )
                                .opacity(self.showTextHigh ? 1 : 0)
                                .animation(Animation.linear(duration: 1).delay(1.5))
                                .onAppear() {
                                    self.showTextHigh = true
                                }
                                .padding(.all, 50)

                        }
                        NavigationLink(destination:
                                        infoPage()) {
                            Text("?")
                                .fontWeight(.bold)
                        }
                        .opacity(self.showTextHigh ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.5))
                        .onAppear() {
                            self.showTextHigh = true
                        }
                        .font(.system(size: 50))
                    }
                    HStack {
                        NavigationLink(destination:
                                        hideDataPage()) {
                            Rectangle()
                                .fill(Color.red.opacity(0.75))
                                .cornerRadius(15)
                                .frame(width: 200, height: 70)
                                .overlay(
                                    Text("Hide Data")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .font(.title)
                                        .opacity(self.showTextLow ? 1 : 0)
                                        .animation(Animation.linear(duration: 1).delay(1.5))
                                        .onAppear() {
                                            self.showTextLow = true
                                        }
                                )
                                .opacity(self.showTextLow ? 1 : 0)
                                .animation(Animation.linear(duration: 1).delay(1.5))
                                .onAppear() {
                                    self.showTextLow = true
                                }
                                .offset(CGSize(width: -20, height: 0))
                                .padding(.all, 50)
                        }

                        .opacity(self.showTextHigh ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.5))
                        .onAppear() {
                            self.showTextHigh = true
                        }
                        .font(.system(size: 50))
                    }
                }
            }
        }
    }
}

struct infoPage: View {
    var body: some View {
        ZStack {
            Image("IMG_002")
                .resizable()
                .scaledToFill()
                .frame(width:750, height:500)
            
            VStack(alignment: .center) {
                Text("Share Data")
                    .fontWeight(.bold)
                    .font(.system(size: 65))
                Text("Share location to enhance the experience of other users.")
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .frame(width:200,height:100)
                Text("Hide Data")
                    .fontWeight(.bold)
                    .font(.system(size: 65))
                Text("Hide location data but keep access to our content.")
                    .fontWeight(.bold)
                    .font(.system(size:20))
                    .frame(width:200,height:100)
            }
            .padding(50)

        }
        .multilineTextAlignment(.center)
    }

}

struct shareDataPage: View {
    @State private var showStreetSmarts = false
    @StateObject var deviceLocationService = DeviceLocationService.shared
    @State var tokens: Set<AnyCancellable> = []
    @State var coordinates: (lat: Double, lon: Double) = (0,0)
    @State var response: String = ""
    
    var body: some View {
            NavigationView {
                VStack(spacing: 60) {
                    Image("logo")
                        .resizable()
                        .frame(width:300,height:200)
                        .opacity(self.showStreetSmarts ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.0))
                        .onAppear() {
                            self.showStreetSmarts = true
                        }
                    Text("Latitude: \(coordinates.lat)")
                        .font(.largeTitle)
                        .onAppear {
                            observeCoordinateUpdates()
                            observeLocationAccessDenied()
                            deviceLocationService.requestlocationUpdates()
                        }
                        .opacity(self.showStreetSmarts ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.5))
                        .onAppear() {
                            self.showStreetSmarts = true
                        }
                    Text("Longitude: \(coordinates.lon)")
                        .font(.largeTitle)
                        .onAppear {
                            observeCoordinateUpdates()
                            observeLocationAccessDenied()
                            deviceLocationService.requestlocationUpdates()
                        }
                        .opacity(self.showStreetSmarts ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.5))
                        .onAppear() {
                            self.showStreetSmarts = true
                        }
                    Image("IMG_004")
                        .resizable()
                        .frame(width:75,height:75)
                        .opacity(self.showStreetSmarts ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.75))
                        .onAppear() {
                            self.showStreetSmarts = true
                        }
//                    Button(action: {
//                                // Create the URLRequest
//                                let url = URL(string: "http://192.168.1.19:5000/kmeans")!
//                                var request = URLRequest(url: url)
//                                request.httpMethod = "POST"
//                                // Create the CSV file data
//                                let csv = "Latitude,Longitude\n36.12,86.67\n33.94,118.40\n32.21,110.92\n37.33,121.88"
//                                let data = csv.data(using: .utf8)!
//                                // Add the data to the request
//                                request.httpBody = data
//                                request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
//                                // Send the request
//                                URLSession.shared.dataTask(with: request) { data, response, error in
//                                  if let error = error {
//                                    self.response = "Error: \(error.localizedDescription)"
//                                  } else {
//                                    self.response = "Data sent successfully!"
//                                  }
//                                }.resume()
//                              }) {
//                                Text("Populate Map")
//                                      .font(.largeTitle)
//                                      .opacity(self.showStreetSmarts ? 1 : 0)
//                                      .animation(Animation.linear(duration: 1).delay(1.75))
//                                      .onAppear() {
//                                          self.showStreetSmarts = true
//                                      }
//
//                              }
//                    Text(response)
                    Text("")
                        .navigationBarTitle("", displayMode: .inline)
                        .toolbar {
                            ToolbarItemGroup(placement:.bottomBar) {
                                Button(action: {}) {
                                Image(systemName: "house")
                                .font(.system(size: 40))
                                }
                                NavigationLink(destination: ThirdPage()) {
                                    Image(systemName: "map")
                                        .font(.system(size: 40))
                                        .frame(width:70,height:10)
                                }
                                NavigationLink(destination: statSharePage()) {
                                    Image(systemName: "chart.bar")
                                        .font(.system(size: 40))
                                        .frame(width:100,height:10)
                                }
                                NavigationLink(destination: settingsSharePage()) {
                                    Image(systemName: "gear")
                                        .font(.system(size: 40))
                                }
                            }
                        }
                }
        }
            .navigationBarHidden(true)
        
    }
    func observeCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { coordinates in
                self.coordinates = (coordinates.latitude, coordinates.longitude)
            }
            .store(in: &tokens)
    }
    func observeLocationAccessDenied() {
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Show some kind of alert to the user")
            }
            .store(in: &tokens)
    }
}

struct hideDataPage: View {
    @State private var showStreetSmarts = false
    var body: some View {
            NavigationView {
                VStack(spacing: 100) {
                    Image("logo")
                        .resizable()
                        .frame(width:300,height:200)
                        .opacity(self.showStreetSmarts ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.0))
                        .onAppear() {
                            self.showStreetSmarts = true
                        }
                    Text("Location Sharing is off")
                        .font(.largeTitle)
                        .opacity(self.showStreetSmarts ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.5))
                        .onAppear() {
                            self.showStreetSmarts = true
                        }
                    Image("IMG_003")
                        .resizable()
                        .frame(width:175,height:100)
                        .opacity(self.showStreetSmarts ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.75))
                        .onAppear() {
                            self.showStreetSmarts = true
                        }
                    Text("")
                        .navigationBarTitle("", displayMode: .inline)
                        .toolbar {
                            ToolbarItemGroup(placement:.bottomBar) {
                                Button(action: {}) {
                                Image(systemName: "house")
                                .font(.system(size: 40))
                                }
                                NavigationLink(destination: ThirdPage()) {
                                    Image(systemName: "map")
                                        .font(.system(size: 40))
                                        .frame(width:70,height:10)

                                }
                                NavigationLink(destination: statHidePage()) {
                                    Image(systemName: "chart.bar")
                                        .font(.system(size: 40))
                                        .frame(width:100,height:10)
                                }
                                NavigationLink(destination: settingsHidePage()) {
                                    Image(systemName: "gear")
                                        .font(.system(size: 40))
                                }
                            }
                        }
                }
        }
            .navigationBarHidden(true)
    }
}


struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

let locations = [
    Location(name:"Test", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)) // currLat, currLong
]


struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}
struct ThirdPage: View {
    @State var coordinateRegion: MKCoordinateRegion = {
        var newRegion = MKCoordinateRegion()
        newRegion.center.latitude = 33.9505
        newRegion.center.longitude = -83.3750
        newRegion.span.latitudeDelta = 0.04
        newRegion.span.longitudeDelta = 0.04
        return newRegion
    }()
    var annotationItems: [MyAnnotationItem] = [
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.95055247, longitude: -83.37443977)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.93776312, longitude: -83.36897076)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.96057116, longitude: -83.37354267)),
        
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 30.83220454, longitude: -83.27790089)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.78632666, longitude: -84.38372351)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 32.46772251, longitude: -84.98956001)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 32.83866952, longitude: -83.63109835)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 34.20785463, longitude: -84.14022725)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 34.9819045, longitude: -85.2872025)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 30.84629471, longitude: -83.27796394)),
        
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.94376265, longitude: -118.40600789)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 35.21086952, longitude: -80.95100097)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 39.85697386, longitude: -104.66674243)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 47.40307195, longitude: -122.27005555)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 40.77035464, longitude: -73.8799819)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 32.89830075, longitude: -97.03897696)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.64072632, longitude: -84.42928674)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 39.17558238, longitude: -76.68915714)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 42.36253084, longitude: -71.01614285)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 33.943174, longitude: -118.32737197)),
    ]
    var body: some View {
        VStack {
            Map(coordinateRegion: $coordinateRegion,
                annotationItems: annotationItems) {item in
                MapPin(coordinate: item.coordinate)
            }
                .edgesIgnoringSafeArea(.all)
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

// longitude, latitude, military time in string format
let data = [[40.23, 50.7, "12:20"], [59.21, 427.22, "1:35"], [12.78, 100.5, "22:50"]]


// JSON PARSING EXAMPLE
let json = """
{
    "user1": {
        "Position": {
            "Longitude": 9.96233,
            "Latitude": 49.80404,
            "Time": "2023-02-24T02:32:59.45+01:00"
        }
    }
}
"""


// JSON PARSING... user.position.longitude?
    struct User: Decodable {
        struct Position: Decodable {
            let longitude: Double
            let latitude: Double
        let time: String
            
            private enum CodingKeys: String, CodingKey {
                case longitude = "Longitude"
                case latitude = "Latitude"
            case time = "Time"
            }
        }
        
        let position: Position
        
        private enum CodingKeys: String, CodingKey {
            case position = "Position"
        }
    }


struct statSharePage: View {
    @State private var showStats = false
    var body: some View {
        NavigationView {
            VStack(spacing: 1) {
                Text("About Us")
                    .fontWeight(.bold)
                    .font(.system(size: 80))
                    .opacity(self.showStats ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(1.0))
                    .onAppear() {
                        self.showStats = true
                    }
                VStack(alignment: .center) {
                    Text("We are a group of CS and CSE students at UGA that came together to build a iOS product for UGA's 2023 Hackathon.")
                        .frame(width:300,height:300)
                        .fontWeight(.bold)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .opacity(self.showStats ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.0))
                        .onAppear() {
                            self.showStats = true
                        }
                }
                Image("IMG_4327")
                    .resizable()
                    .frame(width:350,height:300)
                    .cornerRadius(15)
                    .opacity(self.showStats ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(1.50))
                    .onAppear() {
                        self.showStats = true
                    }
                Text("")
                    .navigationBarTitle("", displayMode: .inline)
                    .toolbar {
                        ToolbarItemGroup(placement:.bottomBar) {
                            NavigationLink(destination: shareDataPage()) {
                                Image(systemName: "house")
                                    .font(.system(size: 40))
                            }
                            NavigationLink(destination: ThirdPage()) {
                                Image(systemName: "map")
                                    .font(.system(size: 40))
                                    .frame(width:70,height:10)

                            }
                            Button(action: {}) {
                            Image(systemName: "chart.bar")
                            .font(.system(size: 40))
                            .frame(width:100,height:10)
                            }
                            NavigationLink(destination: settingsSharePage()) {
                                Image(systemName: "gear")
                                    .font(.system(size: 40))
                            }
                        }
                    }
            }
    }
        .navigationBarHidden(true)
    }
}

struct statHidePage: View {
    @State private var showStats = false
    var body: some View {
        NavigationView {
            VStack(spacing: 1) {
                Text("About Us")
                    .fontWeight(.bold)
                    .font(.system(size: 80))
                    .opacity(self.showStats ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(1.0))
                    .onAppear() {
                        self.showStats = true
                    }
                VStack(alignment: .center) {
                    Text("We are a group of CS and CSE students at UGA that came together to build a iOS product for UGA's 2023 Hackathon.")
                        .frame(width:300,height:300)
                        .fontWeight(.bold)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .opacity(self.showStats ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.0))
                        .onAppear() {
                            self.showStats = true
                        }
                }
                Image("IMG_4327")
                    .resizable()
                    .frame(width:350,height:300)
                    .cornerRadius(15)
                    .opacity(self.showStats ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(1.50))
                    .onAppear() {
                        self.showStats = true
                    }
                Text("")
                    .navigationBarTitle("", displayMode: .inline)
                    .toolbar {
                        ToolbarItemGroup(placement:.bottomBar) {
                            NavigationLink(destination: hideDataPage()) {
                                Image(systemName: "house")
                                    .font(.system(size: 40))
                            }
                            NavigationLink(destination: ThirdPage()) {
                                Image(systemName: "map")
                                    .font(.system(size: 40))
                                    .frame(width:70,height:10)

                            }
                            Button(action: {}) {
                            Image(systemName: "chart.bar")
                            .font(.system(size: 40))
                            .frame(width:100,height:10)
                            }
                            NavigationLink(destination: settingsHidePage()) {
                                Image(systemName: "gear")
                                    .font(.system(size: 40))
                            }
                        }
                    }
            }
    }
        .navigationBarHidden(true)
    }
}

struct settingsSharePage: View {
    @State private var showSettings = false
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                Text("Settings")
                    .fontWeight(.bold)
                    .font(.system(size: 60))
                    .opacity(self.showSettings ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(1.0))
                    .onAppear() {
                        self.showSettings = true
                    }
                Image("IMG_005")
                    .resizable()
                    .frame(width:100,height:100)
                    .opacity(self.showSettings ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(1.50))
                    .onAppear() {
                        self.showSettings = true
                    }
                NavigationLink(destination: hideDataPage()) {
                    Text("Disable Location Sharing")
                        .fontWeight(.bold)
                        .font(.title)
                        .opacity(self.showSettings ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.75))
                        .onAppear() {
                            self.showSettings = true
                        }
                }
                Text("")
                    .navigationBarTitle("", displayMode: .inline)
                    .toolbar {
                        ToolbarItemGroup(placement:.bottomBar) {
                            NavigationLink(destination: shareDataPage()) {
                                Image(systemName: "house")
                                    .font(.system(size: 40))
                            }
                            NavigationLink(destination: ThirdPage()) {
                                Image(systemName: "map")
                                    .font(.system(size: 40))
                                    .frame(width:70,height:10)

                            }
                            NavigationLink(destination: statSharePage()) {
                                Image(systemName: "chart.bar")
                                    .font(.system(size: 40))
                                    .frame(width:100,height:10)
                            }
                            Button(action: {}) {
                            Image(systemName: "gear")
                            .font(.system(size: 40))
                            }
                        }
                    }
            }
    }
        .navigationBarHidden(true)
    }
}

struct settingsHidePage: View {
    @State private var showSettings = false
    var body: some View {
        NavigationView {
            VStack(spacing: 100) {
                Text("Settings")
                    .fontWeight(.bold)
                    .font(.system(size: 60))
                    .opacity(self.showSettings ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(1.0))
                    .onAppear() {
                        self.showSettings = true
                    }
                Image("IMG_005")
                    .resizable()
                    .frame(width:100,height:100)
                    .opacity(self.showSettings ? 1 : 0)
                    .animation(Animation.linear(duration: 1).delay(1.50))
                    .onAppear() {
                        self.showSettings = true
                    }
                NavigationLink(destination: shareDataPage()) {
                    Text("Enable Location Sharing")
                        .fontWeight(.bold)
                        .font(.title)
                        .opacity(self.showSettings ? 1 : 0)
                        .animation(Animation.linear(duration: 1).delay(1.75))
                        .onAppear() {
                            self.showSettings = true
                        }
                }
                Text("")
                    .navigationBarTitle("", displayMode: .inline)
                    .toolbar {
                        ToolbarItemGroup(placement:.bottomBar) {
                            NavigationLink(destination: hideDataPage()) {
                                Image(systemName: "house")
                                    .font(.system(size: 40))
                            }
                            NavigationLink(destination: ThirdPage()) {
                                Image(systemName: "map")
                                    .font(.system(size: 40))
                                    .frame(width:70,height:10)

                            }
                            NavigationLink(destination: statHidePage()) {
                                Image(systemName: "chart.bar")
                                    .font(.system(size: 40))
                                    .frame(width:100,height:10)
                            }
                            Button(action: {}) {
                            Image(systemName: "gear")
                            .font(.system(size: 40))
                            }
                        }
                    }
            }
    }
        .navigationBarHidden(true)
    }
}


// k means clustering with data
// algorithm finds clusters similar to each other in data
// k = # of centroids. (should adjust this based on sample size of data)
// centroid finds data points nearest to it and adds it to its cluster.
// find best possible # of k with algomatter. the centroids will be hot spots on the map (FINAL GOAL!)
// use "elbow technique" to find the datapoint with the best ratio of # of k to SSE
// perform data preprocessing by removing outliers. do not want to show one person going home for the night
// we want to show many people flocking to the bars, etc, not one person or outlier.

