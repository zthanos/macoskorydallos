//
//  ApinidotesView.swift
//  korydallos
//
//  Created by user172589 on 9/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI
import UIKit
import WebKit


struct ApinidotesView: View {
    @State private var infoDetailresults = [InfoDetailElement]()
    private let detailid : Int
    @State private var response : InfoDetailElement? = nil
    @State private var htmlText : String = ""
    let webview1 = WKWebView()
    init(detail_id: Int) {
        detailid = detail_id
        
    }
    
    var body: some View {
        VStack{
            if response != nil {
                Image(response!.cover)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HStack{
                ForEach(response!.imageurls, id:\.id){ sub in
                    
                    Image(sub.imageuri)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    }
                }
                HtmlView(htmlString:  htmlText, encoded: true)
                .padding()
                    .font(.title)
                    //.scaledToFit()

                Spacer()
            }
            
            
        }.onAppear(perform: loadData)
        
        
    }
    
    func loadData(){
        
        guard let url = URL(string: "https://cp.leadersoft.gr/api/v1/infodetail/" + String(detailid))
            else {
                print("Invalid URL")
                return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data {
                
                
                if let decodedResponse = try? JSONDecoder().decode(InfoDetail.self, from: data) {
                    DispatchQueue.main.async {
                        self.response = decodedResponse[0]
                        self.htmlText = decodedResponse[0].infoDetailDescription
                     /*
                            self.htmlText = "<html><body><h1>This is the title</h1><p>This is the first paragraph.</p><img src=\"https://miro.medium.com/max/9216/1*QzxcfBpKn5oNM09-vxG_Tw.jpeg\" width=\"360\" height=\"240\"><p>This is the second paragraph.</p><p>This is the third paragraph.</p><p>This is the fourth paragraph.</p><p>This is the last paragraph.</p></body></html>"*/
 
                        print(self.htmlText)
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

struct ApinidotesView_Previews: PreviewProvider {
    static var previews: some View {
        ApinidotesView(detail_id: 1)
    }
}


