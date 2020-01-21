//
//  VectorView.swift
//  VicAirQuality
//
//  Created by Jacob Gold on 18/1/20.
//  Copyright © 2020 Jacob Gold. All rights reserved.
//

import SwiftUI

struct VectorView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var vector: HealthVector
    
    var body: some View {
        HStack(alignment: .center) {
            Text(vector.healthAdvice.asIcon())
            .accessibility(hidden: true)
            
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(vector.healthParameter)
                        .font(.subheadline)
                        .bold()

                    Text(vector.healthAdvice.description)
                        .padding(EdgeInsets(top: 1, leading: 4, bottom: 1, trailing: 4))
                        .background(Color.init(vector.healthAdvice.asColor()))
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        .cornerRadius(4)
                        .font(.system(size: 11.5))
                }.accessibilityElement(children: .combine)
                
                Spacer()
            }.frame(width: 82)
            
            ProgressBar(value: vector.healthAdvice.asProgress(),
                        maxValue: 1.0,
                        backgroundEnabled: true,
                        backgroundColor: Color.gray.opacity(0.5),
                        foregroundColor: Color.init(vector.healthAdvice.asColor()))
                .frame(maxWidth: 200.0, maxHeight: 10.0)
                .accessibility(hidden: true)
            
            HStack(alignment: .bottom, spacing: 2) {
                Spacer()
                Text("\(String(vector.averageValue))")
                Text(vector.unit)
                    .font(.system(size: 9))
            }.frame(width: 75)
            .accessibilityElement(children: .combine)
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
        .padding([.leading])
        .accessibility(label: Text("Health Parameter"))
    }
}

struct VectorView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VectorView(vector: HealthVector(averageValue: 0.18, healthParameter: "CO2", unit: "mm/pg", healthAdvice: Quality(string: "moderate"), updatedDate: Date()))
            VectorView(vector: HealthVector(averageValue: 0.18, healthParameter: "PM2.5", unit: "mm/pg", healthAdvice: Quality(string: "hazardous"), updatedDate: Date()))
            VectorView(vector: HealthVector(averageValue: 0.18, healthParameter: "SO", unit: "mm/pg", healthAdvice: Quality(string: "good"), updatedDate: Date()))
            VectorView(vector: HealthVector(averageValue: 0.18, healthParameter: "CO", unit: "mm/pg", healthAdvice: Quality(string: "poor"), updatedDate: Date()))
            VectorView(vector: HealthVector(averageValue: 0.18, healthParameter: "PM10", unit: "mm/pg", healthAdvice: Quality(string: "verypoor"), updatedDate: Date()))
        }
        .frame(maxWidth: 380)
    }
}
