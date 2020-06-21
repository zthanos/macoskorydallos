//
//  CardView.swift
//  korydallos
//
//  Created by user172589 on 7/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI
extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

struct CardView: View {
    @Environment(\.imageCache) var cache : ImageCache
    var image: String
    var category: String
    var heading: String
    var author: String
    
    
    var body: some View {
        
        VStack{
            
            
            HStack{
                VStack(alignment: .leading){
                    Text(category)
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Text(author)
                        .font(.title)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .lineLimit(5)
                    Text(heading)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .layoutPriority(100000)
                Spacer()
            }
            HStack{
                AsyncImage(
                    url: URL(string: image)!,
                    placeholder: Text("Loading..."),
                    cache: self.cache
                ).aspectRatio(contentMode: .fill )
            }
        }
        .padding()
        
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a border with Rounded Corners", author: "Thanos Z")
    }
}
