//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 15/2/2024.
//

import Combine
import SwiftUI

class ARManager{
    static let shared = ARManager()
    private init(){}
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}

enum ARAction{
    case placeBlock(color: Color)
    case removeAllAnchors
    case beer
}
