//
//  MapPin.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 15/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    let siteID: String
    let action: (() -> Void)?

    init(coordinate: CLLocationCoordinate2D,
         title: String? = nil,
         subtitle: String? = nil,
         siteID: String,
         action: (() -> Void)? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.siteID = siteID
        self.action = action
    }
}
