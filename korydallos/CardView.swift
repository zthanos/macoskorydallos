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
    
        VStack(alignment: .leading){
            Text(category)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(author)
                .font(.title)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .lineLimit(5)
            if category == "Twitter"{
                Text(heading)
                    .font(.caption)
                    .foregroundColor(.secondary)
                AsyncImage(
                    url: URL(string: image)!,
                    placeholder: Text("Loading..."),
                    cache: self.cache
                ).aspectRatio(contentMode: .fit )
            } else {
                VStack(alignment: .leading){
                   
                   Text(ClearHtmlTags(string: heading))
                        .lineLimit(5)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    AsyncImage(
                        url: URL(string: image)!,
                        placeholder: Text("Loading..."),
                        cache: self.cache
                    ).aspectRatio(contentMode: .fill)
                }
                
            }
        }
    }
    
    
    // }
    
    func ClearHtmlTags(string: String) -> String{
        let str = string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return str;
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a border with Rounded Corners", author: "Thanos Z")
    }
}
