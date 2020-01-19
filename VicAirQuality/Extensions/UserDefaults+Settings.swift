//
//  UserDefaults+Settings.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 14/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation

extension UserDefaults {
    struct Keys {
        private init() {}
        
        static let defaultSiteID = "defaultSiteID"
        static let lastUpdate = "lastUpdate"
    }
}


// Easier manipulation of defaultSiteID
extension UserDefaults {
    /// Default site is Alphington
    class var defaultSiteID: String {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: UserDefaults.Keys.defaultSiteID) == nil {
            UserDefaults.set(defaultSiteID: "c69ed768-34d2-4d72-86f3-088c250758a8")
        }
        
        return userDefaults.string(forKey: UserDefaults.Keys.defaultSiteID) ?? "c69ed768-34d2-4d72-86f3-088c250758a8"
    }
    
    class func set(defaultSiteID: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(defaultSiteID, forKey: UserDefaults.Keys.defaultSiteID)
    }
}


// Easier manipulation of lastUpdate
extension UserDefaults {
    class var lastUpdate: Double {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: UserDefaults.Keys.lastUpdate) == nil {
            UserDefaults.set(lastUpdate: 0)
        }
        
        return userDefaults.double(forKey: UserDefaults.Keys.lastUpdate)
    }
    
    class func set(lastUpdate: Double) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(lastUpdate, forKey: UserDefaults.Keys.lastUpdate)
    }
}
