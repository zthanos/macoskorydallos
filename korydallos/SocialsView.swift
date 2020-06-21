//
//  SocialsView.swift
//  korydallos
//
//  Created by user172589 on 7/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI


struct Responseold: Decodable{
    var Author: String
    var CreatedAt: String
    var Description: String
    var DisplayImage: String
    var HashKey: String
    var Id : String
    var ProfileUrl: String
    var PublishedAt: String
    var Source : String
    var SourceType: String
    var Title: String
    var UrlToImage: String
    var UserName: String
}

struct ResponseElement: Codable {
    let author: String?
    let createdAt: String?
    let responseDescription: String
    let displayImage: Int?
    let hashKey: String?
    let id: Int
    let profileURL: String?
    let publishedAt: String?
    let source: Int
    let sourceType: String?
    let title: String?
    let urlToImage: String
    let userName: String?
    
    enum CodingKeys: String, CodingKey {
        case author = "Author"
        case createdAt = "CreatedAt"
        case responseDescription = "Description"
        case displayImage = "DisplayImage"
        case hashKey = "HashKey"
        case id = "Id"
        case profileURL = "ProfileUrl"
        case publishedAt = "PublishedAt"
        case source = "Source"
        case sourceType = "SourceType"
        case title = "Title"
        case urlToImage = "UrlToImage"
        case userName = "UserName"
    }
}

typealias Response = [ResponseElement]

struct SocialsView: View {
    @State private var results = [ResponseElement]()
    var body: some View {
        VStack{
           // TopBarWithoutNav()
            
            List(results, id: \.id){ item in
                
                CardView(image: item.urlToImage,category: item.sourceType ?? " ", heading: item.responseDescription, author: item.author ?? " ").padding()
            }
            .onAppear(perform: loadData)
        }.padding()
    }
    
    
    
    func loadData(){
        
        guard let url = URL(string: "https://cp.leadersoft.gr/api/v1/retrieveFeeds")
            else {
                print("Invalid URL")
                return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                
                
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse
                    }
                    return
                }
                else{
                    
                }
                
            }
            print("Fetch Failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
    }
    
    
}

struct SocialsView_Previews: PreviewProvider {
    static var previews: some View {
        SocialsView()
    }
}


