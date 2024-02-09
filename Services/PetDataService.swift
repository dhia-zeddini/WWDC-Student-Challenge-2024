//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 9/2/2024.
//

import Foundation
import CoreData
class PetDataService {
    let context: NSManagedObjectContext
      
      init(context: NSManagedObjectContext = CoreDataStack.shared.persistentContainer.viewContext) {
          self.context = context
      }
      
    func savePet(name: String, type: String,sexe:String,
                 breed: String, birthDate: Date,
                 weight:String,imagePath:String,
                 isNeutered: Bool, isAllergic:Bool,
                 lastVaccinationDate: Date
    ) {
          let pet = Pet(context: context)
          pet.name = name
          pet.type = type
          pet.sexe = sexe
          pet.breed = breed
          pet.birthDate = birthDate
          pet.weight = weight
          pet.imagePath = imagePath
          pet.isNeutered = isNeutered
          pet.isAllergic = isAllergic
          pet.lastVaccinationDate = lastVaccinationDate
          
          // ...

          do {
              try context.save()
              print(" save pet succ")
          } catch {
              print("Failed to save pet: \(error)")
          }
      }
}
