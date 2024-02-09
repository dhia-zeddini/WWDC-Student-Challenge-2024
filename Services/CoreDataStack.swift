//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 9/2/2024.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetModel")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        return container
    }()
    private func createModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        let petEntity = NSEntityDescription()
        petEntity.name = "Pet"
        petEntity.managedObjectClassName = NSStringFromClass(Pet.self)

        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.attributeType = .stringAttributeType
        nameAttribute.isOptional = false

        let typeAttribute = NSAttributeDescription()
        typeAttribute.name = "type"
        typeAttribute.attributeType = .stringAttributeType
        typeAttribute.isOptional = false
        
        let sexeAttribute = NSAttributeDescription()
        sexeAttribute.name = "sexe"
        sexeAttribute.attributeType = .stringAttributeType
        sexeAttribute.isOptional = false

        let breedAttribute = NSAttributeDescription()
        breedAttribute.name = "breed"
        breedAttribute.attributeType = .stringAttributeType
        breedAttribute.isOptional = false

        let birthDateAttribute = NSAttributeDescription()
        birthDateAttribute.name = "birthDate"
        birthDateAttribute.attributeType = .dateAttributeType
        birthDateAttribute.isOptional = false
        
        let weightAttribute = NSAttributeDescription()
        weightAttribute.name = "weight"
        weightAttribute.attributeType = .stringAttributeType
        weightAttribute.isOptional = false
        
        // ImagePath attribute
         let imageAttribute = NSAttributeDescription()
         imageAttribute.name = "imagePath"
         imageAttribute.attributeType = .stringAttributeType
         imageAttribute.isOptional = false
        
         let isNeuteredAttribute = NSAttributeDescription()
         isNeuteredAttribute.name = "isNeutered"
         isNeuteredAttribute.attributeType = .booleanAttributeType
         isNeuteredAttribute.isOptional = false
        
        let isAllergicAttribute = NSAttributeDescription()
        isAllergicAttribute.name = "isAllergic"
        isAllergicAttribute.attributeType = .booleanAttributeType
        isAllergicAttribute.isOptional = false

        let lastVaccinationDateAttribute = NSAttributeDescription()
        lastVaccinationDateAttribute.name = "lastVaccinationDate"
        lastVaccinationDateAttribute.attributeType = .dateAttributeType
        lastVaccinationDateAttribute.isOptional = false
        
        
         petEntity.properties = [nameAttribute, typeAttribute,sexeAttribute, breedAttribute,birthDateAttribute,weightAttribute, imageAttribute, isNeuteredAttribute,isAllergicAttribute,lastVaccinationDateAttribute]

        model.entities = [petEntity]

        return model
    }
}
