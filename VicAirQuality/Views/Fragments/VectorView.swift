//
//  VectorView.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct VectorView: View {
    @State var vector: HealthVector
    
    var body: some View {
        VStack{
            HStack{
                Text(vector.healthAdvice.asIcon())
                
                Text(vector.healthParameter)
                    .font(.subheadline)
                    .bold()
                
                Text(vector.healthAdvice.description)
                    .opacity(0.8)
                
                Spacer()
            }
            
            HStack(spacing: 0) {
                Group {
                    Text("\(String(vector.averageValue))")
                    Text(vector.unit)
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

struct VectorView_Previews: PreviewProvider {
    static var previews: some View {
        VectorView(vector: HealthVector(averageValue: 0.18, healthParameter: "CO2", unit: "mm/pg", healthAdvice: Quality(string: "Good"), updatedDate: Date()))
    }
}
