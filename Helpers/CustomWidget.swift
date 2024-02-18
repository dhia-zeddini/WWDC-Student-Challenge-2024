//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 18/2/2024.
//

import SwiftUI

struct CustomWidget: View {
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                VStack {
                    Image("dog-image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(30)
                    
                    VStack{
                        HStack{
                            VStack(spacing: 10){
                                Text( "Name")
                                    .font(.custom(Constants.customFont, size: 30))
                                    .bold()
                                
                                Text( "Breed")
                                    .font(.custom(Constants.customFont, size: 20))
                            }.padding(.horizontal)
                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                            HStack{
                                
                                Text("10.5 Kg")
                                    .font(.custom(Constants.customFont, size: 20))
                            }
                            .padding()
                            .background(.white)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 30,
                                        bottomLeadingRadius: 30,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 0
                                    )
                                )
                                .shadow(radius: 0.5)
                        }
                    }.padding(.top,30)
                       // .padding(.horizontal)
                        .background(.white)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 30,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 30
                            )
                        )
                        .shadow(radius: 2)
                }
            }
            .padding(.top,30)
  
        }
        .padding(.horizontal)
            .background(.white)
            .cornerRadius(30)
            .shadow(radius: 5)
            //.draggable()
    }
}

#Preview {
    CustomWidget()
}
