//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 18/2/2024.
//


import SwiftUI
import Algorithms
import UniformTypeIdentifiers

struct CustomWidgetModel: Codable,Hashable ,Transferable{
    let id :UUID
    let title: String
    let imageT: String
    
    static var transferRepresentation: some TransferRepresentation{
        CodableRepresentation(contentType: .html)
    }
}
extension UTType{
    static let develperTask = UTType(exportedAs: "com.dhia.animalpose.DragAndDrop")
}


struct MockData{
    
    static let taskOne = CustomWidgetModel(id :UUID(),title: "Appointments",imageT: "appointments")
    static let taskTwo = CustomWidgetModel(id :UUID(),title: "Diet Plan",imageT: "dietPlan")
    static let taskThee = CustomWidgetModel(id :UUID(),title: "Trining Tips",imageT: "trining")
    static let taskFour = CustomWidgetModel(id :UUID(),title: "Accessories",imageT: "accessories")
}
