//
//  InformationsView.swift
//  korydallos
//
//  Created by user172589 on 8/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI
import Foundation

// MARK: - InfoMasterElement
struct InfoMasterElement: Codable {
    let action, infoMasterDescription: String
    let id: Int
    let imageurl: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case action
        case infoMasterDescription = "description"
        case id, imageurl, title
    }
}

typealias InfoMaster = [InfoMasterElement]

struct InformationsView: View {
    @State private var results = [InfoMasterElement]()
    
    var body: some View {
        
        VStack{
           // ScrollView{
                
                List(results, id: \.id){ item in
                    
                   
                    NavigatedCardView(image: item.imageurl, category: " ", heading: (item.infoMasterDescription), author: (item.title), id: item.id)
                        //  .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                    
                }  .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                //  }//.id(UUID())
                
          //  }
            
        }.onAppear(perform: loadData)
        
        
    }
    
    func loadData(){
        
        guard let url = URL(string: "https://cp.leadersoft.gr/api/v1/infomaster")
            else {
                print("Invalid URL")
                return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(InfoMaster.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse
                    }
                    return
                }
                
            }
            print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
    
}

struct InformationsView_Previews: PreviewProvider {
    static var previews: some View {
        InformationsView()
    }
}

