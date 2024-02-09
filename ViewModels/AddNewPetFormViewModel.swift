//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 9/2/2024.
//

import Foundation
class AddNewPetFormViewModel: ObservableObject {
    
    @Published var petName: String = ""
    @Published var selectedSexe: AddNewPetForm.Sexe = .male
    @Published var selectedType: AddNewPetForm.PetType = .dog
    @Published var selectedBreed: String = ""
    @Published var petBirthDate: Date = Date()
    @Published var isAlergic: Bool = false
    @Published var isNeutered: Bool = false
    @Published var isSick: Bool = false
    @Published var kilos: Int = 0
    @Published var grams: Int = 0
    @Published var unitOfMeasure: String = "kg"
    @Published var lastVaccinationDate: Date = Date()

    let dogBreeds = ["Labrador Retriever", "German Shepherd", "Golden Retriever"]
    let catBreeds = ["Persian", "Maine Coon", "Siamese"]

    var breedOptions: [String] {
        switch selectedType {
        case .dog:
            return dogBreeds
        case .cat:
            return catBreeds
        }
    }
    private var service: PetDataService

        init(service: PetDataService = PetDataService()) {
            self.service = service
        }
    func savePet() {
        let weight = "\(kilos).\(grams)"+unitOfMeasure
        let imagePth="test.png"
        service.savePet(name: "petName", type: selectedType.rawValue, sexe: selectedSexe.rawValue, breed: selectedBreed, birthDate: petBirthDate,weight: weight, imagePath: imagePth, isNeutered: isNeutered, isAllergic: isAlergic, lastVaccinationDate: lastVaccinationDate)
    }
}
