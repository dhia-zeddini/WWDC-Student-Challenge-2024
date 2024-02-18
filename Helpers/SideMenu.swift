//
//  SideMenu.swift
//  Shop_Trolly
//
//  Created by Zeddin Dhia on 23/1/2024.
//

import SwiftUI

struct SideMenu: View {
    
    
    @Binding var isVisible: Bool
    let draggableWidgets: [CustomWidgetModel]
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(spacing: 20){
                
                ScrollView{
                    VStack{
                        ForEach(draggableWidgets, id: \.id) { widget in
                            CustomWidget(draggableWidget: widget)
                                .draggable(widget)

                        }
                    }.padding()
                    //.frame()
                }
                .ignoresSafeArea(.all)
                
                
                Spacer()
            }
            // .padding()
            //.padding(.horizontal,40)
            .frame(width: geometry.size.width / 3.5, height: geometry.size.height, alignment: .leading)
            .background(.clear)
            .offset(x: isVisible ? 0 : -UIScreen.main.bounds.width)
            .animation(.easeInOut, value: isVisible)
            
            
        }
    }
}

#Preview {
    HomeView()
}
