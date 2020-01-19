//
//  LastUpdated.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 20/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct LastUpdated: View {
    @Binding var date: Double
    
    var body: some View {
        HStack {
            Spacer()
        
            Text("Last Updated: \(Date(timeIntervalSince1970: date).shortLocalDescription())")
                .opacity(0.8)
                .font(.system(size: 9.0))
        }
        .padding([.leading, .trailing, .bottom])
    }
}

struct LastUpdated_Previews: PreviewProvider {
    static var previews: some View {
        LastUpdated(date: .constant(Date().timeIntervalSince1970))
    }
}
