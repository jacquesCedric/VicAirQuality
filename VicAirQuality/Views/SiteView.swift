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

    var allSites = EPABridge()
    
    @State var pins: [MapPin] = []
    @State var selectedPin: MapPin?
    
    var body: some View {
        VStack {
            HStack {
                MapButton(pins: $pins, selectedPin: $selectedPin)
                    .padding([.leading, .bottom, .top])
                    .onTapGesture {
                        self.allSites.fetchAllMonitoringSites() { sites in
                            self.pins = sites.allLocationsAsMapPins()
                        }
                }
                
                Text("\(siteFetcher.currentSite?.siteName ?? "Site Data Unavailable")")
                    .font(.title)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                    .padding([.trailing, .bottom, .top])
                
                Spacer()
            }
            
            SiteDetails(site: $siteFetcher.currentSite)
                .padding(EdgeInsets(top: -25, leading: 0, bottom: 0, trailing: 0))
            
            Spacer()
            
            HStack {
                LastUpdated(date: $siteFetcher.lastLocalUpdate)
                Spacer()
                QuitButton()
                    .padding([.trailing, .bottom])
            }
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
