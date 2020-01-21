//
//  SimpleAirMonitoringSite.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 12/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation
import MapKit

struct SimpleAirMonitoringSite: MonitoringSite {
    let siteID: String
    let siteName: String
    let siteType: String
    
    let siteLocation: Coordinates
    let siteHealthAdvice: HealthVector?
    
    func worstQuality() -> Quality {
        return self.siteHealthAdvice?.healthAdvice ?? Quality(degree: .unknown)
    }
}

extension SimpleAirMonitoringSite {
    init?(json: [String: Any]) {
        guard let siteID = json["siteID"] as? String,
            let siteName = json["siteName"] as? String,
            let siteType = json["siteType"] as? String,
            let coordinates = json["geometry"] as? [String: Any],
            let siteHealthAdvices = json["siteHealthAdvices"] as? [[String: Any]]
        else {
            return nil
        }
        
        var advices: Set<HealthVector> = []
        for adviceData in siteHealthAdvices {
            guard let advice = HealthVector(simpleJson: adviceData) else {
                continue
            }
            
            advices.insert(advice)
        }
        
        self.siteID = siteID
        self.siteName = siteName
        self.siteType = siteType
        self.siteLocation = Coordinates(json: coordinates) ?? Coordinates(latitude: 0.0, longitude: 0.0)
        self.siteHealthAdvice = advices.first
    }
}


extension SimpleAirMonitoringSite {
    /// MapPin representation of a site.
    /// - siteName maps to title
    /// - health advice description maps to  subtitle
    /// - coordinates map directly
    func asMapPin() -> MapPin {
        let pin = MapPin(coordinate: CLLocationCoordinate2D(latitude: self.siteLocation.latitude, longitude: self.siteLocation.longitude),
                         title: self.siteName,
                         subtitle: self.siteHealthAdvice?.healthAdvice.description,
                         siteID: self.siteID,
                         color: self.worstQuality().asColor(),
                         action: nil)
        
        return pin
    }
}


// Deal with Hashable and Equatable
extension SimpleAirMonitoringSite {
    static func == (lhs: SimpleAirMonitoringSite, rhs: SimpleAirMonitoringSite) -> Bool {
        return lhs.siteID == rhs.siteID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(siteID)
    }
}
