//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 12/2/2024.
//

import SwiftUI

struct ARVieww: View {
    var body: some View {
        CustomARViewRepresentable()
            .ignoresSafeArea() 
    }
}

#Preview {
    LandingView()
}
