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
        HStack(alignment: .center) {
            Text(vector.healthAdvice.asIcon())
            
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(vector.healthParameter)
                        .font(.subheadline)
                        .bold()

                    Text(vector.healthAdvice.description)
                        .opacity(0.8)
                        .foregroundColor(Color.init(vector.healthAdvice.asColor()))
                }
                Spacer()
            }.frame(width: 75)
            
            
            
            ProgressBar(value: vector.healthAdvice.asProgress(),
                        maxValue: 1.0,
                        backgroundEnabled: true,
                        backgroundColor: Color.gray.opacity(0.5),
                        foregroundColor: Color.init(vector.healthAdvice.asColor()))
                .frame(maxWidth: 200.0, maxHeight: 10.0)
            
            HStack(alignment: .bottom, spacing: 2) {
                Spacer()
                Text("\(String(vector.averageValue))")
                Text(vector.unit)
                    .font(.system(size: 9))
            }.frame(width: 75)
        }
        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
        .padding([.leading])
    }
}

struct VectorView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VectorView(vector: HealthVector(averageValue: 0.18, healthParameter: "CO2", unit: "mm/pg", healthAdvice: Quality(string: "moderate"), updatedDate: Date()))
        }
        .frame(maxWidth: 380)
    }
}
