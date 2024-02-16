//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 15/2/2024.
//

import Combine

class ARManager{
    static let shared = ARManager()
    private init(){}
    
    var actionStream = PassthroughSubject<ARAction, Never>()
}
