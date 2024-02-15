//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 15/2/2024.
//

import SwiftUI

struct CustomARViewRepresentable: UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        return CustomARView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
