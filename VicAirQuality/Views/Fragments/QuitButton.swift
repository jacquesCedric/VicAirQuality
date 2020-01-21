//
//  QuitButton.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 20/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct QuitButton: View {
    @State var hovered: Bool = false
    
    var body: some View {
        Button(action: {
            AppDelegate.shared().quitApplication()
        }) {
            HStack(alignment: .center, spacing: 10) {
                if hovered {
                    Text("Quit")
                }
                Image(nsImage: NSImage(named: NSImage.stopProgressTemplateName)!)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: self.hovered ? 80 : 30, height: 30)
        .background(self.hovered ? Color.red : Color.blue)
        .foregroundColor(Color.white)
        .cornerRadius(15)
        .onHover {_ in
            withAnimation {
                self.hovered.toggle()
            }
        }
        .accessibility(hint: Text("Quit application"))
    }
}

struct QuitButton_Previews: PreviewProvider {
    static var previews: some View {
        QuitButton()
    }
}
