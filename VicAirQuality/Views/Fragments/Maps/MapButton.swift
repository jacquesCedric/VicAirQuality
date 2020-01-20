//
//  MapButton.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct MapButton: View {
    @State var hovered: Bool = false
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
            .scaleEffect(self.hovered ? 0.75 : 0.85)
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: 30, height: 30)
        .background(Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(15)
        .popover(
            isPresented: self.$showMap,
            arrowEdge: .bottom
        ) {
            MapView(pins: self.$pins, selectedPin: self.$selectedPin)
            .edgesIgnoringSafeArea(.all)
            .padding()
            .frame( minWidth: 400, minHeight: 400)
        }
        .onHover {_ in
            withAnimation {
                self.hovered.toggle()
            }
        }
        
    }
}

struct MapButton_Previews: PreviewProvider {
    static var previews: some View {
        MapButton(pins: .constant([MapPin]()), selectedPin: .constant(nil))
    }
}
