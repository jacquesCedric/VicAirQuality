//
//  DetailedAirMonitoringSite.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 13/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation

struct DetailedAirMonitoringSite: MonitoringSite {
    let siteID: String
    let siteName: String
    let siteType: String
    
    let siteLocation: Coordinates
    let siteHealthAdvice: Set<HealthVector>?
}

extension DetailedAirMonitoringSite {
    init?(json: [String: Any]) {
        guard let siteID = json["siteID"] as? String,
            let siteName = json["siteName"] as? String,
            let siteType = json["siteType"] as? String,
            let coordinates = json["geometry"] as? [String: Any],
            let siteHealthAdvices = json["parameters"] as? [[String: Any]]
        else {
            return nil
        }
        
        var advices: Set<HealthVector> = []
        for adviceData in siteHealthAdvices {
            guard let advice = HealthVector(complexJson: adviceData) else {
                continue
            }
            
            advices.insert(advice)
        }
        
        self.siteID = siteID
        self.siteName = siteName
        self.siteType = siteType
        self.siteLocation = Coordinates(json: coordinates) ?? Coordinates(latitude: 0.0, longitude: 0.0)
        self.siteHealthAdvice = advices
    }
}

// Deal with Hashable and Equatable
extension DetailedAirMonitoringSite {
    static func == (lhs: DetailedAirMonitoringSite, rhs: DetailedAirMonitoringSite) -> Bool {
        return lhs.siteID == rhs.siteID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(siteID)
    }
}
