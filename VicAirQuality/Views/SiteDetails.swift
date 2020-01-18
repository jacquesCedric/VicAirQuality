//
//  SiteDetails.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct SiteDetails: View {
    @State var site: DetailedAirMonitoringSite
    
    var body: some View {
        VStack {
            Text("Details here")
        }
        .padding()
    }
}

struct SiteDetails_Previews: PreviewProvider {
    static var previews: some View {
        SiteDetails(site: DetailedAirMonitoringSite(siteID: "test",
                                                    siteName: "test",
                                                    siteType: "test",
                                                    siteLocation: Coordinates(latitude: 0.0, longitude: 0.0),
                                                    siteHealthAdvice: Set<HealthVector>()))
    }
}