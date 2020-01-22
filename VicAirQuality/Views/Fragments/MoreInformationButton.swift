//
//  MoreInformationButton.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 22/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct MoreInformationButton: View {
    @Binding var site: DetailedAirMonitoringSite?
    
    var body: some View {
        Button(action: {
            if let url = URL(string: "https://www.epa.vic.gov.au/for-community/airwatch?siteId=\(self.site?.siteID ?? "")") {
                NSWorkspace.shared.open(url)
                AppDelegate.shared().togglePopover(AppDelegate.shared())
            }
        }) {
            Image(nsImage: NSImage(named: NSImage.touchBarGetInfoTemplateName)!)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct MoreInformationButton_Previews: PreviewProvider {
    static var previews: some View {
        Text("No mockup")
    }
}
