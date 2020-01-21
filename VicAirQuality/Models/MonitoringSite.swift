//
//  MonitoringSite.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 13/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation

protocol MonitoringSite: Hashable {
    var siteID: String { get }
    var siteName: String { get }
    var siteType: String { get }
    
    var siteLocation: Coordinates { get }
    
    func worstQuality() -> Quality
}
