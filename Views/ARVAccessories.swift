//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 12/2/2024.
//

import SwiftUI

struct ARVAccessories: View {
    @State private var colors: [Color] = [
        .green,
        .red,
        .blue
    ]
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea()
            .overlay(alignment: .bottom){
                ScrollView(.horizontal){
                    HStack{
                        Button("Bed"){
                            ARManager.shared.actionStream.send(.beer)
                        }.frame(width: 30,height: 30)
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(16)
                        
                        Button{
                            ARManager.shared.actionStream.send(.removeAllAnchors)
                        }label: {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30,height: 30)
                                .padding()
                                .background(.regularMaterial)
                                .cornerRadius(16)
                        }
                        
                        ForEach(colors, id: \.self){ color in
                            Button{
                                ARManager.shared.actionStream.send(.placeBlock(color: color))
                            }label: {
                                color
                                    .frame(width: 30,height: 30)
                                    .padding()
                                    .background(.regularMaterial)
                                    .cornerRadius(16)
                            }
                        }
                    }.padding()
                }
            }
    }
}

#Preview {
    LandingView()
}
