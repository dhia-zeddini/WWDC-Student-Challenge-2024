//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 19/2/2024.
//

import SwiftUI

struct DropArea: View {
    let columnLayout = Array(repeating:GridItem() , count: 2)
    let dropWidgets: [CustomWidgetModel]
    let isTargeted: Bool
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(isTargeted ? .teal.opacity(0.15) : Color(.clear))
            if dropWidgets.isEmpty{
                VStack {
                    HStack(spacing: 30){
                        
                        VStack(spacing: 30){
                            placeholderWidget
                            placeholderWidget
                        }
                        VStack(spacing: 30){
                            placeholderWidget
                            placeholderWidget
                        }
                    }
                    Text("Failed to create 0x88 image slot (alpha=1 wide=1) (client=0xac3b36ab) [0x5 (os/kern) failure]")
                         .font(.custom(Constants.customFont, size: 20))
                         .bold()
                }
            }else{
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columnLayout, spacing: 36) {
                        ForEach(dropWidgets, id: \.id) { widget in
                            CustomWidget(draggableWidget: widget )
                        }
                    }
                    .padding()
                }
            }
        }
    }
    private var placeholderWidget: some View {
        VStack(alignment: .center){
            Image("dog-image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
            Text("TiTle")
                .font(.custom(Constants.customFont, size: 40))
                .bold()
                .padding(.bottom,30)
           
        }
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 1)
        .blur(radius: 8)
       
    }
}
#Preview {
    HomeView()
}
