//
//  File.swift
//  
//
//  Created by Zeddin Dhia on 9/2/2024.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class AddNewPetFormViewModel: ObservableObject {
    private var viewContext: NSManagedObjectContext
    
    @Published var petName: String = ""
    @Published var selectedSexe: AddNewPetForm.Sexe = .male
    @Published var selectedType: AddNewPetForm.PetType = .dog
    @Published var selectedBreed: String = ""
    @Published var petBirthDate: Date = Date()
    @Published var isAllergic: Bool = false
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
    
    private var imageService: ImageStorageService

    
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""

  
    init(imageService: ImageStorageService = ImageStorageService()) {
        self.viewContext = PersistenceController.shared.container.viewContext
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
        guard !petName.isEmpty, !selectedBreed.isEmpty, kilos != 0 else {
            alertTitle = "Error"
            alertMessage = "Please fill in all required fields."
            showAlert = true
            return
        }

        let weight = "\(kilos).\(grams)" + unitOfMeasure
        var imagePath: String? = nil
        if let selectedImage = selectedImage {
            imagePath = imageService.saveImageToDocumentDirectory(selectedImage)
            if imagePath == nil {
                alertTitle = "Error"
                alertMessage = "Failed to save the image. Please try again."
                showAlert = true
                return
            }
        } else {
            alertTitle = "Error"
            alertMessage = "Please select an image for the pet."
            showAlert = true
            return
        }

        let pet = Pet(context: viewContext)
        pet.name = petName
        pet.type = selectedType.rawValue
        pet.sexe = selectedSexe.rawValue
        pet.breed = selectedBreed
        pet.birthDate = petBirthDate
        pet.weight = weight
        pet.imagePath = imagePath ?? "dog-image"
        pet.isNeutered = isNeutered
        pet.isAllergic = isAllergic
        pet.lastVaccinationDate = lastVaccinationDate
        
        do {
            try viewContext.save()
            alertTitle = "Success"
            alertMessage = "The pet has been added successfully."
            showAlert = true
            showHomeView = true
        } catch {
            alertTitle = "Error"
            alertMessage = "There was an error saving the pet. Please try again."
            showAlert = true
            print("Failed to save pet: \(error)")
        }
    }

}
