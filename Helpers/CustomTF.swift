//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 8/2/2024.
//

import SwiftUI

struct CustomTF: View {
   
    var hint: String
    var label: String
    var isPassword: Bool = false
    @State var showPassword: Bool = false
    
    @Binding var value: String
    var body: some View {
        HStack(alignment: .top,spacing: 15, content: {
          
            HStack{
                Text(label)
            }
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Color.themeSecondary)
            .cornerRadius(20)
            .shadow(radius: 1)
            .blur(radius: 0.5)
            
            
            VStack{
                
                TextField(hint,text: $value)
            }
            .padding()
            .background(Color.themeSecondary)
            .cornerRadius(20)
            .shadow(radius: 1)
     
        })
    }
}

#Preview {
    AddNewPetForm()
}
