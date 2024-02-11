import SwiftUI
import CoreData
struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        // Creating the entity
        let petEntity = NSEntityDescription()
        petEntity.name = "Pet"
        petEntity.managedObjectClassName = "Pet"
        
       
        let nameAttribute = NSAttributeDescription()
        nameAttribute.name = "name"
        nameAttribute.type = .string
        nameAttribute.isOptional = false

        let typeAttribute = NSAttributeDescription()
        typeAttribute.name = "type"
        typeAttribute.type = .string
        typeAttribute.isOptional = false
        
        let sexeAttribute = NSAttributeDescription()
        sexeAttribute.name = "sexe"
        sexeAttribute.type = .string
        sexeAttribute.isOptional = false

        let breedAttribute = NSAttributeDescription()
        breedAttribute.name = "breed"
        breedAttribute.type = .string
        breedAttribute.isOptional = false

        let birthDateAttribute = NSAttributeDescription()
        birthDateAttribute.name = "birthDate"
        birthDateAttribute.type = .date
        birthDateAttribute.isOptional = false
        
        let weightAttribute = NSAttributeDescription()
        weightAttribute.name = "weight"
        weightAttribute.type = .string
        weightAttribute.isOptional = false
        
        // ImagePath attribute
         let imageAttribute = NSAttributeDescription()
         imageAttribute.name = "imagePath"
         imageAttribute.type = .string
         imageAttribute.isOptional = false
        
         let isNeuteredAttribute = NSAttributeDescription()
         isNeuteredAttribute.name = "isNeutered"
         isNeuteredAttribute.type = .boolean
         isNeuteredAttribute.isOptional = false
        
        let isAllergicAttribute = NSAttributeDescription()
        isAllergicAttribute.name = "isAllergic"
        isAllergicAttribute.type = .boolean
        isAllergicAttribute.isOptional = false

        let lastVaccinationDateAttribute = NSAttributeDescription()
        lastVaccinationDateAttribute.name = "lastVaccinationDate"
        lastVaccinationDateAttribute.type = .date
        lastVaccinationDateAttribute.isOptional = false
        
        
         petEntity.properties = [nameAttribute, typeAttribute,sexeAttribute, breedAttribute,birthDateAttribute,weightAttribute, imageAttribute, isNeuteredAttribute,isAllergicAttribute,lastVaccinationDateAttribute]

     
       
        let model = NSManagedObjectModel()
        model.entities = [petEntity]
        
        
        container = NSPersistentContainer(name: "PetCareApp", managedObjectModel: model)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
