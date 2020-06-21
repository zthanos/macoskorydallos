//
//  CallerButtonView.swift
//  korydallos
//
//  Created by user172589 on 8/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI


struct CallerButtonView: View {
    var btnImage: String
    var description: String
    var phoneNumber: String
    
    var body: some View {
        ZStack{
            //Color.White
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
            VStack{
                Image(btnImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 110 )
                HStack{
                    Image("phone-volume-solid")
                        .resizable()
                        .frame(width: 18, height: 18 )
                    Text(description)
                        .frame( alignment: .center)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
            }
            .padding()
            .layoutPriority(100)
                // .background(Color.white)
                // .shadow(radius: 3)
                
                // .border(Color.purple, width: 1)
                .onTapGesture(){
                    print("Tapped")
                    if let url = URL(string: "tel://" + self.phoneNumber), UIApplication.shared.canOpenURL(url) {
                        if #available(iOS 10, *) {
                            UIApplication.shared.open(url)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                    
            }
        }.frame(width: 140)
        
    }
}

struct CallerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CallerButtonView(btnImage: "korydallos_logo_new", description: "Δήμος Κορυδαλλού", phoneNumber: "2104990500")
    }
}
