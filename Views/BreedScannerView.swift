//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 12/2/2024.
//

import SwiftUI

struct BreedScannerView: View {
    var body: some View {
        if #available(macOS 14.0, iOS 17.0, tvOS 17.0, *){
            CameraPreview()
                        .edgesIgnoringSafeArea(.all)
        }else{
            Text("This feacher is available only in macOS 14.0, iOS 17.0, tvOS 17.0")
        }
        
    }
}

#Preview {
    LandingView()
}
