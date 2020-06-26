//
//  MyPlacesMap.swift
//  korydallos
//
//  Created by Korydallos on 22/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces

struct MyPlacesMap: UIViewRepresentable {
      private let locationManager = CLLocationManager()
      private let dataProvider = GoogleDataProvider()
      private let searchRadius: Double = 5000
    private var searchedTypes = ["bank", "bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    
    @State private var resultsCityBound = [CityBound]()
    
    typealias CityBounds = [CityBound]
    
    
    func makeUIView(context: Self.Context) -> GMSMapView{
        let  camera = GMSCameraPosition.camera(withLatitude: 37.9871,
                                               longitude: 23.6451,
                                               zoom: 15.0)
        let mapview = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        self.loadDataCity(mapview: mapview)
        mapview.settings.zoomGestures = true
        //mapview.settings.
        let coordinates = CLLocationCoordinate2D(latitude: 37.9871, longitude: 23.6451)
        fetchPlaces(near:  coordinates, mapview: mapview)
        /*
        do {
            if let styleURL = Bundle.main.url(forResource: "mapplacesStyle", withExtension: "json") {
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
        */
        return mapview
    }
    
    func fetchPlaces(near coordinate: CLLocationCoordinate2D, mapview : GMSMapView) {
      mapview.clear()
      
      dataProvider.fetchPlaces(
        near: coordinate,
        radius: searchRadius,
        types: searchedTypes
      ) { places in
        places.forEach { place in
            print(place)
          let marker = PlaceMarker(place: place, availableTypes: self.searchedTypes)
          marker.map = mapview
        }
      }
    }
    
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        
    }
    
    func loadDataCity(mapview : GMSMapView){
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
                        self.setBoundaries(mapview: mapview)
                    }
                    return
                }
            }
            print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
    
    private func setBoundaries(mapview : GMSMapView){
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
}

struct MyPlacesMap_Previews: PreviewProvider {
    static var previews: some View {
        MyPlacesMap()
    }
}
class PlaceMarker: GMSMarker {
  // 1
  let place: GooglePlace

  // 2
  init(place: GooglePlace, availableTypes: [String]) {
    self.place = place
    super.init()

    position = place.coordinate
    groundAnchor = CGPoint(x: 0.5, y: 1)
    appearAnimation = .pop

    var foundType = "restaurant"
    let possibleTypes = availableTypes.count > 0 ?
      availableTypes :
      ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]

    for type in place.types {
      if possibleTypes.contains(type) {
        foundType = type
        break
      }
    }
    icon = UIImage(named: foundType+"_pin")
  }
}
