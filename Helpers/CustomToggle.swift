//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 9/2/2024.
//

import SwiftUI

struct CustomToggle: View {
    var label: String
    @Binding var isToggle: Bool
    var body: some View {
        HStack{
            Toggle(label, isOn: $isToggle)
                .toggleStyle(SwitchToggleStyle(tint: Color.themeBlue))
        }  .padding()
            .background(Color.themeSecondary)
            .cornerRadius(30)
            .shadow(radius: 1)
    }
}

#Preview {
    AddNewPetForm()
}
