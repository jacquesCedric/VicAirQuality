//
//  Date+ShortLocalDescription.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 20/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation

extension Date {
    func shortLocalDescription() -> String {
        let df = DateFormatter()
        let formatter = DateFormatter.dateFormat(fromTemplate: "HH:mm, MM/dd/yy", options: 0, locale: .current)
        
        df.dateFormat = formatter
        
        return df.string(from: self)
    }
}
