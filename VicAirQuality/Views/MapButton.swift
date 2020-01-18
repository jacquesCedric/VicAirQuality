//
//  MapButton.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct MapButton: View {
    @State var showMap: Bool = false
    @Binding var pins: [MapPin]
    @Binding var selectedPin: MapPin?
    
    var body: some View {
        Button(action: {
            self.showMap = true
        }) {
            ZStack(alignment: .leading) {
                Image(nsImage: NSImage(named: NSImage.touchBarExitFullScreenTemplateName)!)
                Image(nsImage: NSImage(named: NSImage.touchBarExitFullScreenTemplateName)!)
                    .rotationEffect(Angle(degrees: 90.0))
            }
            .scaleEffect(0.8)
        }
        .popover(
            isPresented: self.$showMap,
            arrowEdge: .bottom
        ) {
            MapView(pins: self.$pins, selectedPin: self.$selectedPin)
            .edgesIgnoringSafeArea(.all)
            .padding()
            .frame( minWidth: 400, minHeight: 400)
        }
        
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton(pins: .constant([MapPin]()), selectedPin: .constant(nil))
    }
}
