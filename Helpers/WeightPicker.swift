//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 9/2/2024.
//

import SwiftUI

struct WeightPicker: View {
    @Binding var kilos: Int
        @Binding var grams: Int
        @Binding var unitOfMeasure: String
        
        let kilosRange = Array(0...100)
        let gramsRange = Array(0...9)
        let unitOfMeasureOptions = ["kg", "lbs"]
        
        var body: some View {
            HStack {
                Picker("Kilos", selection: $kilos) {
                    ForEach(kilosRange, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
                Picker("Grams", selection: $grams) {
                    ForEach(gramsRange, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                
                Picker("Unit", selection: $unitOfMeasure) {
                    ForEach(unitOfMeasureOptions, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
            .compositingGroup()
            .clipped()
        }
    }

#Preview {
    AddNewPetForm()
}
