//
//  MyplacesView.swift
//  korydallos
//
//  Created by user172589 on 8/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI

struct MyplacesView: View {
    let pop : UIView =  PopupMapOptions()
    var body: some View {
        VStack{
            MyPlacesMap()
            .edgesIgnoringSafeArea(.top)
        }
        
       
    }
    
    func onButtonClick(){

    }
}

struct MyplacesView_Previews: PreviewProvider {
    static var previews: some View {
        MyplacesView()
    }
}
