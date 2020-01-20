//
//  SiteDetails.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct SiteDetails: View {
    @Binding var site: DetailedAirMonitoringSite?
    
    var body: some View {
        VStack {
            site?.siteHealthAdvice.map { set in
                ForEach(Array(set).sorted(by: { $0.healthParameter > $1.healthParameter}), id: \.self) { advice in
                    VectorView(vector: advice)
                }
            }
        }
        .padding()
    }
}

struct SiteDetails_Previews: PreviewProvider {
    static var previews: some View {
        SiteDetails(site: .constant(DetailedAirMonitoringSite(siteID: "test",
                                                    siteName: "test",
                                                    siteType: "test",
                                                    siteLocation: Coordinates(latitude: 0.0, longitude: 0.0),
                                                    siteHealthAdvice: Set<HealthVector>())))
    }
}
