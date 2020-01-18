//
//  Quality.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 13/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import AppKit

struct Quality {
    /// The indicator of quality
    let grade: degree

    /// Create a new indicator of air quality
    /// - Parameter string: A string that describes quality
    /// - VIC EPA API uses the following describers: Good, Moderate, Poor, Very Poor, Hazardous. Default is unknown
    init(string: String) {
        let formatted = string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        self.grade = degree(rawValue: formatted) ?? .unknown
    }
}


extension Quality {
    /// A graded scale of quality
    enum degree: String {
        case unknown
        case good
        case moderate
        case poor
        case verypoor
        case hazardous
    }
}


extension Quality {
    /// Emoji icon representation of quality. Employs the same colour code as official VIC
    /// EPA resources
    func asIcon() -> String {
        switch(grade) {
        case .unknown:
            return "⚪️"
        case .good:
            return "🟢"
        case .moderate:
            return "🟡"
        case .poor:
            return "🟠"
        case .verypoor:
            return "🔴"
        case .hazardous:
            return "🟣"
        }
    }
    
    /// Colour representation of quality. Employs the same colour code as official VIC
    /// EPA resources.
    func asColor() -> NSColor {
        switch(grade) {
        case .unknown:
            return NSColor(calibratedRed: 179, green: 179, blue: 179, alpha: 1.0)
        case .good:
            return NSColor(calibratedRed: 100, green: 161, blue: 59, alpha: 1.0)
        case .moderate:
            return NSColor(calibratedHue: 235, saturation: 197, brightness: 28, alpha: 1.0)
        case .poor:
            return NSColor(calibratedHue: 214, saturation: 121, brightness: 0, alpha: 1.0)
        case .verypoor:
            return NSColor(calibratedHue: 169, saturation: 7, brightness: 54, alpha: 1.0)
        case .hazardous:
            return NSColor(calibratedHue: 80, saturation: 3, brightness: 30, alpha: 1.0)
        }
    }
}


extension Quality: CustomStringConvertible {
    var description: String {
        switch(self.grade) {
        case .unknown:
            return "No Data"
        case .good:
            return "Good"
        case .moderate:
            return "Moderate"
        case .poor:
            return "Poor"
        case .verypoor:
            return "Very Poor"
        case .hazardous:
            return "Hazardous"
        }
    }
}
