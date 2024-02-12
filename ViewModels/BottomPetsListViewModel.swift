//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 10/2/2024.
//

import Foundation
import SwiftUI
import CoreData

class BottomPetsListViewModel: ObservableObject {
    @Published var pets: [Pet] = []
    @Published var selectedPet: Pet?
    private var imageService: ImageStorageService
     
    private var viewContext: NSManagedObjectContext
    
    init(imageService: ImageStorageService = ImageStorageService()) {
        self.viewContext = PersistenceController.shared.container.viewContext
        self.imageService = imageService
        fetchPets()
    }
    
    func fetchPets() {
        let request = NSFetchRequest<Pet>(entityName: "Pet")
        do {
            pets = try viewContext.fetch(request)
        } catch {
            print("Failed to fetch tasks: \(error)")
        }
    }

    func loadImageFromPath(_ path: String?) -> UIImage {
        guard let path = path, let image = imageService.loadImageFromDocumentDirectory(fileName: path) else {
            return UIImage(named: "dog-image") ?? UIImage()
        }
        return image
    }
}
