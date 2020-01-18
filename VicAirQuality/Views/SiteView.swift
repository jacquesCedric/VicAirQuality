//
//  SiteView.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct SiteView: View {
    @ObservedObject var siteFetcher = CurrentSiteFetcher()
//    @ObservedObject var allSites = EPASitesFetcher()
    var allSites = EPABridge()
    
    @State var pins: [MapPin] = []
    @State var selectedPin: MapPin?
    
    var body: some View {
        VStack {
            Text("\(siteFetcher.currentSite?.siteName ?? "Site Data Unavailable")")
                .padding()
            
            MapView(pins: $pins, selectedPin: $selectedPin)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            self.allSites.fetchAllMonitoringSites() { sites in
                self.pins = sites.allLocationsAsMapPins()
            }
        }
    }
}

struct SiteView_Previews: PreviewProvider {
    static var previews: some View {
        SiteView()
    }
}
