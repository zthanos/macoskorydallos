//
//  HomeUIView.swift
//  korydallos
//
//  Created by user172589 on 7/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI



struct HomeUIView: View {
    
    var body: some View {
        ZStack{
            VStack(alignment:  .leading){
                //  TopBarWithoutNav()
                Image("top_banner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                GoogleMapsView()
                    .edgesIgnoringSafeArea(.top)
            }
            .overlay(
                WeatherView()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0)), alignment: .bottomLeading)
        }
        
    }
}

struct HomeUIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeUIView()
    }
}
