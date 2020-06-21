//
//  InfoDetailModel.swift
//  korydallos
//
//  Created by user172589 on 14/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import Foundation


// MARK: - InfoDetailElement
struct InfoDetailElement: Codable {
    let cover, infoDetailDescription: String
    let id: Int
    let imageurls: [Imageurl]
    let name: String

    enum CodingKeys: String, CodingKey {
        case cover
        case infoDetailDescription = "description"
        case id, imageurls, name
    }
}

// MARK: - Imageurl
struct Imageurl: Codable {
    let id: Int
    let imageuri: String
    let infodetailsid: Int
}

typealias InfoDetail = [InfoDetailElement]
