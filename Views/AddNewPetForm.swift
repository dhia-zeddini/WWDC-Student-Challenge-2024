//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 8/2/2024.
//

import SwiftUI

struct AddNewPetForm: View {
    let screenWidth:CGFloat=Constants.screenWidth
    let screenHeight:CGFloat=Constants.screenHeight
    enum Sexe: String, CaseIterable, Identifiable {
            case male, female
            var id: Self { self }
        }
    enum PetType: String, CaseIterable, Identifiable {
            case dog, cat
            var id: Self { self }
        }
    enum ActiveSheet: Identifiable {
        case photoPicker, camera

        var id: Int {
            self.hashValue
        }
    }

    @StateObject private var viewModel = AddNewPetFormViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: screenWidth/16){
                HStack (spacing: screenWidth/16){
                    petImageSection
                    petDetailsSection
                }
                saveButton
                NavigationLink(destination: HomeView(), isActive: $viewModel.showHomeView) {
                          EmptyView()
                      }
                      .isDetailLink(false)
            }.padding()
                .padding(.horizontal,30)
                .actionSheet(isPresented: $viewModel.showSheet) {
                    ActionSheet(title: Text("Select Image"), message: Text("Choose a source"), buttons: [
                        .default(Text("Camera")) {
                            viewModel.activeSheet = .camera
                        },
                        .default(Text("Gallery")) {
                            viewModel.activeSheet = .photoPicker
                        },
                        .cancel()
                    ])
                }
                .sheet(item: $viewModel.activeSheet) { item in
                    switch item {
                    case .camera:
                        ImagePicker(selectedImage: $viewModel.selectedImage, sourceType: .camera)
                    case .photoPicker:
                        ImagePicker(selectedImage: $viewModel.selectedImage, sourceType: .photoLibrary)
                    }
                }
        }
    }
    private var petImageSection: some View {
            VStack(spacing: 30){
                ZStack {
                    if let selectedImage = viewModel.selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: screenWidth / 3, height: screenWidth / 3)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.themeBlue, lineWidth: 4)
                                    )
                            } else {
                                // Display the default "dog-image" if no image has been selected
                                Image("dog-image")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: screenWidth / 3, height: screenWidth / 3)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.themeBlue, lineWidth: 4)
                                    )
                            }
                    Button(action: {
                        viewModel.showSheet = true
                    }) {
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                        
                    } .padding()
                        .background(Color.themeBlue)
                        .cornerRadius(50)
                        .offset(x: screenWidth / 9, y: screenWidth / 8)
                }
                medicalInfo
            }
    }
    private var petDetailsSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("New Pet")
                .font(.custom(Constants.customFont, size: 50))
                .bold()
                .foregroundColor(.black)
            
            
            CustomTF(hint: "Enter your pet name", label:"Name", value: $viewModel.petName)
                .padding(.top,30)
            HStack{
                typeSelection
                Spacer()
                sexeSelection
            }
            
            Picker("Breed", selection: $viewModel.selectedBreed) {
                ForEach(viewModel.breedOptions, id: \.self) { breed in
                    Text(breed)
                }
            }
            .pickerStyle(.wheel)
            .frame(minHeight: 100)
            .background(RoundedRectangle(cornerRadius:50)
                .fill(Color.themeSecondary))
            .shadow(radius: 1)
            DatePicker(
                "Birth Date",
                selection: $viewModel.petBirthDate,
                displayedComponents: .date
            )
            .padding()
            .background(Color.themeSecondary)
            .cornerRadius(30)
            .shadow(radius: 1)
            HStack{
                Text("Weight :")
                    .font(.custom(Constants.customFont, size: 20))
                   // .bold()
                    .foregroundColor(.black)
                WeightPicker(kilos: $viewModel.kilos, grams: $viewModel.grams, unitOfMeasure: $viewModel.unitOfMeasure)
                    .frame(maxHeight: 100)
                                    .clipped()
                                    .padding(.vertical, 8)
            }
            
            
        }
    }
    private var typeSelection: some View {
        HStack {
            ForEach(PetType.allCases) { type in
                Button(action: {
                    viewModel.selectedType = type
                }) {
                    Image(type.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80,height: 80)
                        //.background(Color.themeLightBlue)
                        .clipShape(Circle())
                        .overlay(
                            viewModel.selectedType == type
                            ? Circle().stroke(Color.themeBlue, lineWidth: 4)
                            : Circle().stroke(.clear, lineWidth: 0)
                        )
                    
                }
            }
            
            
        }.padding()
    }
    private var sexeSelection: some View {
        HStack {
            ForEach(Sexe.allCases) { sexe in
                Button(action: {
                    viewModel.selectedSexe = sexe
                }) {
                    Image(sexe.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80,height: 80)
                       // .background(Color.themeLightBlue)
                        .clipShape(Circle())
                        .overlay(
                            viewModel.selectedSexe == sexe
                            ? Circle().stroke(Color.themeBlue, lineWidth: 4)
                            : Circle().stroke(.clear, lineWidth: 0)
                        )
                    
                }
            }
            
            
        }.padding()
    }
    private var medicalInfo: some View {
        VStack(alignment:.leading,spacing: 20){
            Text("Medical Informations")
                .font(.custom(Constants.customFont, size: 30))
                .foregroundColor(.black)
     
            CustomToggle(label: "Neutered", isToggle: $viewModel.isNeutered)
            CustomToggle(label: "Allergies", isToggle: $viewModel.isAllergic)
         //   CustomToggle(label: "Sick", isToggle: $isAlergic)
            DatePicker(
                           "Last Vaccination Date",
                           selection: $viewModel.lastVaccinationDate,
                           displayedComponents: .date
                       )
                       .padding()
                       .background(Color.themeSecondary)
                       .cornerRadius(30)
                       .shadow(radius: 1)
                    
        }
    }
    private var saveButton: some View {
        Button(action: {
            // Save action
            viewModel.savePet()
            print("saved")
        }) {
            Text("Save")
                .font(.custom(Constants.customFont, size: 40))
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 200)
                .background(Color.themeBlue)
                .cornerRadius(30)
        }
        
    }
    
}

#Preview {
    AddNewPetForm()
}
