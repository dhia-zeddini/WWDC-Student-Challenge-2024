//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 10/2/2024.
//

import Foundation
import SwiftUI

class BottomPetsListViewModel: ObservableObject {
    @Published var pets: [Pet] = []
    @Published var selectedPet: Pet?
    private let petDataService: PetDataService
    private var imageService: ImageStorageService
    
    init(petDataService: PetDataService = PetDataService(),imageService: ImageStorageService = ImageStorageService()) {
        self.petDataService = petDataService
        self.imageService = imageService
        fetchPets()
    }
    
    func fetchPets() {
        pets = petDataService.fetchAllPets()
        print(pets)
        if(!pets.isEmpty){
            selectedPet = pets[0]
        }
        
    }
    func loadImageFromPath(_ path: String?) -> UIImage {
        guard let path = path, let image = imageService.loadImageFromDocumentDirectory(path: path) else {
            return UIImage(named: "defaultPlaceholder") ?? UIImage()
        }
        return image
    }
}
