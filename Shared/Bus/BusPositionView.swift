//
//  BusPositionView.swift
//  SUSTechFlow
//
//  Created by Wycer on 2020/12/3.
//



import SwiftUI
import MapKit
import Foundation


struct BusAnnotation: Identifiable {
    let id = UUID()
    let title : String
    let coordinate : CLLocationCoordinate2D
}


struct BusPositionView: View {
    @Environment(\.presentationMode) var presentation
    let message: String
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.607818, longitude: 114.002316), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.1))
    @State private var trackingMode: MapUserTrackingMode = .follow
    @State private var annotations: [BusAnnotation] = []
    @State private var manager = CLLocationManager()
    @StateObject private var managerDelegate = locationDelegate()
    
    private func getData() {
        if let url = URL(string: "https://bus.sustcra.com/api/v1/bus/monitor/") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode([BusPosition].self, from: data)
                        
                        annotations = res
                            .filter {$0.lat != 0}
                            .map({
                                (value: BusPosition) -> BusAnnotation in
                                print(value)
                                var coordinate = CLLocationCoordinate2D()
                                coordinate.latitude = value.lat
                                coordinate.longitude = value.lng
                                return BusAnnotation(title: "!", coordinate: coordinate)
                            })
                        
                        print(annotations)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    
    var body: some View {
        VStack {
            Text("Real-time position")
            Map(
                coordinateRegion: $region, showsUserLocation: true, userTrackingMode: $trackingMode, annotationItems: annotations) { (position) -> MapMarker in
                MapMarker(coordinate: position.coordinate, tint: .red)
            }
            
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 300, maxHeight: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Button("Close") {
                presentation.wrappedValue.dismiss()
            }
        }.onAppear{
            print("get data")
            manager.delegate = managerDelegate
            getData()
        }
    }
}



struct BusPositionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BusPositionView(message:"?")
            
        }
    }
}

class locationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        
//        if manager.authorizationStatus == .authorizedWhenInUse {
//            print("authorized..")
//            
//            if manager.accuracyAuthorization != .fullAccuracy {
//                print("reduced accuracy...")
//                
//                manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "Location") { (err) in
//                    if err != nil {
//                        print(err!)
//                        
//                        return
//                    }
//                    
//                }
//            }
//            
//            manager.startUpdatingLocation()
//            
//        } else {
//            print("not authorized..")
//            
//            manager.requestWhenInUseAuthorization()
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations: [CLLocation]) {
        print("new location")
    }
}
