//
//  CitiPOIModel.swift
//  korydallos
//
//  Created by user172589 on 11/6/20.
//  Copyright © 2020 user172589. All rights reserved.
//

import Foundation

// MARK: - CittPointsOfInterestElement
struct CityPointsOfInterestElement : Codable {
    let icon: String
    let id: Int
    let lat, lng, subtitle, title: String
    
    
}
