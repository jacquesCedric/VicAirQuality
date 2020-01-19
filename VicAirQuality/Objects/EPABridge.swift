//
//  EPABridge.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation

fileprivate let VICEPAkey = "ec641868165e4831882fde970538726f"

/// Adds headers as suggested by the VIC EPA API.
/// - Parameter request: An URL request for gateway.api.epa.vic.gov.au
fileprivate func addNecessaryHeaders(request: URLRequest) -> URLRequest {
    var withHeaders = request
    
    withHeaders.setValue("", forHTTPHeaderField: "X-TransactionID")
    withHeaders.setValue("", forHTTPHeaderField: "X-TrackingID")
    withHeaders.setValue("", forHTTPHeaderField: "X-SessionID")
    withHeaders.setValue("", forHTTPHeaderField: "X-CreationTime")
    withHeaders.setValue("", forHTTPHeaderField: "X-InitialSystem")
    withHeaders.setValue("", forHTTPHeaderField: "X-InitialComponent")
    withHeaders.setValue("", forHTTPHeaderField: "X-InitialOperation")
    withHeaders.setValue(VICEPAkey, forHTTPHeaderField: "X-API-Key")
    
    return withHeaders
}

final class EPABridge {
    /// Fetches a list of all air monitoring sites from the VIC EPA API.
    /// - Parameter completionBlock: A function that acts on the returned data
    func fetchAllMonitoringSites(completionBlock: @escaping (AirMonitoringSites) -> Void) {
        let urlString = "https://gateway.api.epa.vic.gov.au/environmentMonitoring/v1/sites?environmentalSegment=air"

        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request = addNecessaryHeaders(request: request)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }

            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                guard let allMonitoringSites = AirMonitoringSites(json: json) else {
                    return
                }

                completionBlock(allMonitoringSites)
            }
        }

        task.resume()
    }
}

public class CurrentSiteFetcher: ObservableObject {
    @Published var currentSite: DetailedAirMonitoringSite?
    
    var lastLocalUpdate: Double = UserDefaults.lastUpdate
    var localCurrentID: String = UserDefaults.defaultSiteID
    
    var timer = Timer()
    
    init() {
        fetchCurrentSite()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.checkForUpdate()
        }
    }
    
    /// Check if an update is necessary
    func checkForUpdate() {
        if (localCurrentID != UserDefaults.defaultSiteID) {
            fetchCurrentSite()
            
            return
        }
        
        // Check every 40 Minutes for an update
        let nextUpdate = Date(timeIntervalSince1970: lastLocalUpdate).addingTimeInterval(40 * 60.0)
        
        if (lastLocalUpdate <= 0.0 || nextUpdate <= Date() ) {
            fetchCurrentSite()
            
            return
        }
    }
    
    /// Using information from userdefaults, fetch and parse more recent json for the current site
    func fetchCurrentSite() {
        UserDefaults.set(lastUpdate: Date().timeIntervalSince1970)
        lastLocalUpdate = UserDefaults.lastUpdate
        localCurrentID = UserDefaults.defaultSiteID
        
        let currentID = UserDefaults.defaultSiteID
        
        let urlString = "https://gateway.api.epa.vic.gov.au/environmentMonitoring/v1/sites/\(currentID)/parameters"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request = addNecessaryHeaders(request: request)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                guard let richStation = DetailedAirMonitoringSite(json: json) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.currentSite = richStation
                    
                    AppDelegate.shared().changeMenuTitle(new: self.worstQuality().asIcon())
                }
            }
        }.resume()
    }
    
    
    /// Returns the vector with the worst graded quality at the current site.
    func worstQuality() -> Quality {
        var q: Quality = Quality(string: "unknown")
        
        _ = currentSite?.siteHealthAdvice.map { advice in
            advice.map { vector in                
                if q.asAbsolute() > vector.healthAdvice.asAbsolute() {
                    q = vector.healthAdvice
                }
            }
        }
        
        return q
    }
}
