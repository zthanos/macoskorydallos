//
//  NavigatedCardView.swift
//  korydallos
//
//  Created by Korydallos on 25/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import SwiftUI


struct NavigatedCardView: View {
    @Environment(\.imageCache) var cache : ImageCache
    var image: String
    var category: String
    var heading: String
    var author: String
    var id: Int
    
    
    var body: some View {
        NavigationLink(destination: ApinidotesView(detail_id: id)) {
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
        }
        .padding()
        
    }
}


struct NavigatedCardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatedCardView(image: "swiftui-button", category: "SwiftUI", heading: "Drawing a border with Rounded Corners", author: "Thanos Z", id : 1)
    }
}
