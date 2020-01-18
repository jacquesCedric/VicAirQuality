//
//  ContentView.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        VStack {
//            Text("Hello, World!")
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//            Button(action: {
//                AppDelegate.shared().changeMenuTitle(new: "🟢")
//            }) {
//                Text("switch")
//            }
            
            SiteView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
