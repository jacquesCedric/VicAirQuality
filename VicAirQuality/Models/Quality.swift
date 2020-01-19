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
            return NSColor(calibratedRed: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        case .good:
            return NSColor(calibratedHue: 0.26, saturation: 0.58, brightness: 0.70, alpha: 1.0)
        case .moderate:
            return NSColor(calibratedHue: 0.14, saturation: 0.83, brightness: 0.71, alpha: 1.0)
        case .poor:
            return NSColor(calibratedHue: 0.09, saturation: 1.00, brightness: 0.52, alpha: 1.0)
        case .verypoor:
            return NSColor(calibratedHue: 0.95, saturation: 0.92, brightness: 0.45, alpha: 1.0)
        case .hazardous:
            return NSColor(calibratedHue: 0.94, saturation: 0.88, brightness: 0.27, alpha: 1.0)
        }
    }
    
    func asProgress() -> Double {
        switch(grade) {
        case .unknown:
            return 1.0
        case .good:
            return 1.0
        case .moderate:
            return 0.65
        case .poor:
            return 0.50
        case .verypoor:
            return 0.3
        case .hazardous:
            return 1.0
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
