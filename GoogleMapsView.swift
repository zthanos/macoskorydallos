//
//  GoogleMapsView.swift
//  korydallos
//
//  Created by user172589 on 7/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI
import GoogleMaps
import GooglePlaces


typealias CityPointsResponse = [CityPointsOfInterestElement]


typealias CityBounds = [CityBound]


struct GoogleMapsView: UIViewRepresentable {
    @State private var results = [CityPointsOfInterestElement]()
    @State private var resultsCityBound = [CityBound]()
    @State private static var  camera = GMSCameraPosition.camera(withLatitude: 37.9871507, longitude: 23.645123474382686, zoom: 14.0)
    
    @State private var mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    
    
    let kMapStyle = "[" +
        "  {" +
        "    \"featureType\": \"road.local\"," +
        "    \"elementType\": \"labels\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"visibility\": \"off\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"transit\"," +
        "    \"elementType\": \"labels.icon\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"visibility\": \"off\"" +
        "      }" +
        "    ]" +
        "  }" +
    "]"
    
    
    
    private let zoom: Float = 15.0
    
    func Init(){
        
        self.loadData()
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView{
        self.loadData()
        self.loadDataCity()
        mapview.settings.zoomGestures = true
        
        
        do {
            if let styleURL = Bundle.main.url(forResource: "mapstyle", withExtension: "json") {
                mapview.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
            // Set the map style by passing a valid JSON string.
            //  mapview.mapStyle = try GMSMapStyle(jsonString: kMapStyle)
            //  } catch {
            //    NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        return mapview
    }
    
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        
    }
    
    private func setPOIs(){
        for item in self.results {
            let lat = Double(item.lat)
            let lng = Double(item.lng)
            let position = CLLocationCoordinate2D(latitude:  lat ?? 0, longitude:  lng ?? 0)
            let marker = GMSMarker(position: position)
            // marker.icon = item.id == 6 ? UIImage(named: "pinhospital") : UIImage(named: "pinwifi")
            marker.title = item.title
            marker.snippet = item.subtitle
            //marker.icon = UIImage(item.icon)
            marker.map = self.mapview
            
        }
        
    }
    
    private func setBoundaries(){
        let polygon = GMSPolygon()
        let rect = GMSMutablePath()
        let arr = self.resultsCityBound[0].geojson
        for item in arr.coordinates{
            for sub in item {
                rect.add(CLLocationCoordinate2DMake(sub[1], sub[0]))
            }
        }
        polygon.path = rect
        polygon.fillColor = UIColor(red:0.25, green: 0, blue: 0, alpha: 0.2)
        polygon.strokeColor = UIColor.black
        polygon.strokeWidth = 2
        polygon.map = mapview
    }
    
    func loadData(){
        guard let url = URL(string: "https://cp.leadersoft.gr/api/v1/citipois")
            else {
                print("Invalid URL")
                return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(CityPointsResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse
                        self.setPOIs()
                    }
                    return
                }
            }
            print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    
    func loadDataCity(){
        guard let url = URL(string: "https://nominatim.openstreetmap.org/search.php?q=Municipality+of+korydallos&polygon_geojson=1&format=json")
            else {
                print("Invalid URL")
                return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(CityBounds.self, from: data) {
                    DispatchQueue.main.async {
                        self.resultsCityBound = decodedResponse
                        self.setBoundaries()
                    }
                    return
                }
            }
            print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
}

struct GoogleMapsView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleMapsView()
    }
}
