//
//  HealthVector.swift
//  VIC Air Quality
//
//  Created by Jacob Gold on 13/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import Foundation

struct HealthVector {
    let averageValue: Double
    let healthParameter: String
    let unit: String
    let healthAdvice: Quality
    let updatedDate: Date
}
    
extension HealthVector {
    /// For use with simple station json
    /// - Parameter json: A fragment of json from an All Air Monitoring Sites request
    init?(simpleJson json: [String: Any]) {
        guard let averageValue = json["averageValue"] as? Double,
            let healthParameter = json["healthParameter"] as? String,
            let unit = json["unit"] as? String,
            let healthAdvice = json["healthAdvice"] as? String,
            let updatedDate = json["since"] as? String
        else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        let date = dateFormatter.date(from: updatedDate)
        
        self.averageValue = averageValue
        self.healthParameter = healthParameter
        self.unit = unit
        self.healthAdvice = Quality(string: healthAdvice)
        self.updatedDate = date ?? Date()
    }
}

extension HealthVector {
    /// For use with detailed station json
    /// - Parameter json: A fragment of json from an Air Monitoring Site By Site ID request
    init?(complexJson json: [String: Any]) {
        guard let name = json["name"] as? String else {
            return nil
        }
        
        guard let tsReadings = json["timeSeriesReadings"] as? [[String: Any]] else {
            return nil
        }
        
        var readingsData: [[String: Any]] = []
        for r in tsReadings {
            guard let tname = r["timeSeriesName"] as? String else {
                continue
            }
            
            if tname == "1HR_AV" {
                guard let hrReading = r["readings"] as? [[String: Any]] else {
                    continue
                }
                
                readingsData = hrReading
            }
        }
        
        for r in readingsData {
            var rt = r
            rt["healthParameter"] = name
            guard let a = HealthVector(simpleJson: rt) else {
                return nil
            }
            
            self.averageValue = a.averageValue
            self.healthAdvice = a.healthAdvice
            self.unit = a.unit
            self.healthParameter = a.healthParameter
            self.updatedDate = a.updatedDate
            
            return
        }
        
        return nil
    }
}

extension HealthVector: Hashable {
    static func == (lhs: HealthVector, rhs: HealthVector) -> Bool {
        return lhs.healthParameter == rhs.healthParameter
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(healthParameter)
    }
}
