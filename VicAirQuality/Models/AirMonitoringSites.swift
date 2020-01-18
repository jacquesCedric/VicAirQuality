//
//  AirMonitoringSites.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 12/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation
import MapKit

struct AirMonitoringSites {
    let sites: Set<SimpleAirMonitoringSite>
}

extension AirMonitoringSites {
    init?(json: [String: Any]) {
        guard let sitesJson = json["records"] as? [[String: Any]]
        else { return nil }
        
        var sites: Set<SimpleAirMonitoringSite> = []
        for siteData in sitesJson {
            guard let site = SimpleAirMonitoringSite(json: siteData) else {
                continue
            }
            
            sites.insert(site)
        }
        
        self.sites = sites
    }
}

extension AirMonitoringSites {
    func allLocationsAsMKPointAnnotations() -> [MKPointAnnotation] {
        return self.sites.map{ $0.asMKPointAnnotation() }
    }
    
    func allLocationsAsMapPins() -> [MapPin] {
        return self.sites.map{ $0.asMapPin() }
    }
}
