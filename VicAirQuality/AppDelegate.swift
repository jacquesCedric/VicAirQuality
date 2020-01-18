//
//  AppDelegate.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static func shared() -> AppDelegate {
        return NSApplication.shared.delegate as! AppDelegate
    }
    
    var popover: NSPopover!
    var statusBarItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        let popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 500)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)
        self.popover = popover
        
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        if let button = self.statusBarItem.button {
            button.title = "⚪️"
            button.action = #selector(togglePopover(_:))
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
       if let button = self.statusBarItem.button {
           if self.popover.isShown {
               self.popover.performClose(sender)
           } else {
               self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
               self.popover.contentViewController?.view.window?.becomeKey()
               NSApp.activate(ignoringOtherApps: true)
           }
       }
    }
    
    func changeMenuTitle(new: String) {
        if let button = self.statusBarItem.button {
            button.title = new
        }
    }
}

