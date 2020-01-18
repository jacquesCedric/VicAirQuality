//
//  Coordinates.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 12/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

extension Coordinates {
    init?(json: [String: Any]) {
        guard let geometry = json["coordinates"] as? [Double]
            else { return nil }
        
        self.latitude = geometry[0]
        self.longitude = geometry[1]
    }
}
