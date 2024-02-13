//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 12/2/2024.
//

import SwiftUI

struct BreedScannerView: View {
    var body: some View {
        CameraPreview()
                    .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LandingView()
}