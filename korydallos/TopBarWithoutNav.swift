//
//  TopBarWithoutNav.swift
//  korydallos
//
//  Created by user172589 on 8/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI


struct TopBarWithoutNav: View {
    
    init(){
        //  self.body.backgroundColor = UIColor.red
        
    }
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("22 C")
                    //.font(.title)
                    .fontWeight(.black)
                    .padding()
                    .foregroundColor(Color.white)
                    .scaledToFill()
                VStack(alignment: .center){
                    Image("second")
                    Text("Kyr 22C")
                }
                .foregroundColor(Color.white)
                VStack{
                    Image("second")
                    Text("Kyr 22C")
                }
                .foregroundColor(Color.white)
                VStack{
                    Image("second")
                    Text("Kyr 22C")
                }
                .foregroundColor(Color.white)
                .scaledToFill()
                VStack{
                    Image("second")
                    Text("Kyr 22C")
                }
                .foregroundColor(Color.white)
                .scaledToFill()
                Spacer()
            }
            Text("Aithrios kairos")
                .foregroundColor(Color.white)
                .scaledToFill()
        }
        .background(Color(red: 0.51, green: 0.10, blue: 0.12))
        
    }
}

struct TopBarWithoutNav_Previews: PreviewProvider {
    static var previews: some View {
        TopBarWithoutNav()
    }
}
