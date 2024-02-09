//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 9/2/2024.
//

import Foundation
import CoreData

@objc(Pet)
public class Pet: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var sexe: String
    @NSManaged public var breed: String
    @NSManaged public var birthDate: Date
    @NSManaged public var weight: String
    @NSManaged var imagePath: String
    @NSManaged public var isNeutered: Bool
    @NSManaged public var isAllergic: Bool
    @NSManaged public var lastVaccinationDate: Date
}
