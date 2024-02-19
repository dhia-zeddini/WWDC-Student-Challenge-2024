//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 8/2/2024.
//

import SwiftUI

struct LandingView: View {
    @State private var selectedTab = 1
    var body: some View {
        VStack{
            HStack(spacing: 50) {
                //Spacer()
                TabBarButton(text: "ARView", isHome: false, selectedTab: $selectedTab, assignedTab: 0)
               // Spacer()
                TabBarButton(text: "Home  ", isHome: true, selectedTab: $selectedTab, assignedTab: 1)
                   // .frame(alignment: .center)
               // Spacer()
                TabBarButton(text: "Breed ", isHome: false, selectedTab: $selectedTab, assignedTab: 2)
                //Spacer()
                
            }
            .padding()
            .background(.white)
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 20,
                    bottomTrailingRadius: 20,
                    topTrailingRadius: 0
                )
            )
           // .frame(height: 90)
            .shadow(radius: 2)
            TabView(selection: $selectedTab) {
                ARVAccessories()
                    .tag(0)
                HomeView()
                    .tag(1)
              //  BreedScannerView()
                //    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }.padding(.top, 10)
    }
}


struct TabBarButton: View {
    let text: String
    var isHome: Bool
    @Binding var selectedTab: Int
    let assignedTab: Int

    var body: some View {
        Button(action: {
            selectedTab = assignedTab
        }) {
            Text(text)
                .font(.custom(Constants.customFont, size: 40))
                .foregroundColor(selectedTab == assignedTab ? .blue : .secondary)
        }
    }
}

#Preview {
    LandingView()
}
