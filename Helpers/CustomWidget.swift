//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 18/2/2024.
//

import SwiftUI

struct CustomWidget: View {
    let draggableWidget: CustomWidgetModel
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                VStack(spacing:30) {
                    Image(draggableWidget.imageT)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.themeTestColor)
                        .cornerRadius(30)
                    
                    Text( draggableWidget.title)
                        .font(.custom(Constants.customFont, size: 24))
                        .bold()

                       // .padding(.horizontal)
                        
                }.padding(.bottom,30)
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

