//
//  WeatherView.swift
//  korydallos
//
//  Created by Municipality Of Korydallos on 7/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI


struct WeatherView: View {
    //@State private var weatherData = []()
    @State private var openWeatherResponse = [OpenWeatherResponseElement]()
    @State private var temprature = ""
    @State private var weatherDescr = ""
    
 
    
    var body: some View {
        VStack {
            HStack {
                
                Text(temprature)
                   .font(.title)
                    .padding()
                    .foregroundColor(Color.white)
                    .scaledToFill()
                ForEach(openWeatherResponse, id: \.temprature) {  item in
                    VStack(alignment: .center) {
                        AsyncImage(
                            url: URL(string: item.icon)!,
                            placeholder: Text("...")
                        )

                            .frame(width: 32, height: 32 )
                        Text(item.dayOfTheWeek + " " + item.temprature)
                                                   .font(.caption)
                                                   .fixedSize(horizontal: true, vertical: true)
                                                   .foregroundColor(Color.white)
                                                   .scaledToFit()
                    }
                }
 
/*
                ForEach(openWeatherResponse, id: \.temprature) {  item in
                    VStack(alignment: .center) {
                        AsyncImage(
                            url: URL(string: item.icon)!,
                            placeholder: Text("...")
                        )
                            //.resizable()
                            .frame(width: 32, height: 32 )
                        
                        Text(item.dayOfTheWeek + " " + item.temprature)
                            .font(.caption)
                            .fixedSize(horizontal: true, vertical: true)
                            .foregroundColor(Color.white)
                            .scaledToFit()
                    }
                }
 */
                
                
                Spacer()
            }
            /*
            Text(weatherDescr)
                .foregroundColor(Color.white)
                .font(.footnote)
                // .padding()
                .scaledToFill()
 */
        }
        .background(Color(red: 0.51, green: 0.10, blue: 0.12))
        .onAppear(perform: loadData)
        
        
    }
    
    func loadData() {
        guard let url = URL(string: "https://cp.leadersoft.gr/api/v1/weather")
            else {
                print("Invalid URL")
                return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(OpenWeatherResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.temprature = decodedResponse[0].temprature
                        self.weatherDescr = decodedResponse[0].openWeatherResponseDescription
                        for n in 1...4 {
                            self.openWeatherResponse.append(decodedResponse[n])
                        }
                    }
                    return
                }
            }
            print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
 
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
