//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 9/2/2024.
//

import Foundation
import Combine
import SwiftUI
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
    
    
    @Published var showSheet: Bool = false
    @Published var activeSheet: AddNewPetForm.ActiveSheet?
    @Published var selectedImage: UIImage?
    
    @Published var showHomeView: Bool = false
    
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
    
    //keyboard
    @Published var keyboardHeight: CGFloat = 0
    private var cancellables = Set<AnyCancellable>()
    

    private var service: PetDataService
    private var imageService: ImageStorageService

    init(service: PetDataService = PetDataService(),imageService: ImageStorageService = ImageStorageService()) {
            self.service = service
            self.imageService = imageService
            // Keyboard show
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
                       .map { notification -> CGFloat in
                           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                               return keyboardSize.height
                           }
                           return 0
                       }
                       .assign(to: \.keyboardHeight, on: self)
                       .store(in: &cancellables)

                   // Keyboard hide
                   NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                       .map { _ in CGFloat(0) }
                       .assign(to: \.keyboardHeight, on: self)
                       .store(in: &cancellables)
        }
    func savePet() {
        let weight = "\(kilos).\(grams)"+unitOfMeasure
        let imagePth=imageService.saveImageToDocumentDirectory(selectedImage) ?? "dog-image"
        service.savePet(name: "petName", type: selectedType.rawValue, sexe: selectedSexe.rawValue, breed: selectedBreed, birthDate: petBirthDate,weight: weight, imagePath: imagePth, isNeutered: isNeutered, isAllergic: isAlergic, lastVaccinationDate: lastVaccinationDate)
        showHomeView = true
        print(service.fetchAllPets())
    }
}
