//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 8/2/2024.
//

import SwiftUI
let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height
let customFont: String = "Marker felt"
struct AddNewPetForm: View {
    @State private var value: String=""
    enum Sexe: String, CaseIterable, Identifiable {
            case male, female
            var id: Self { self }
        }
    enum PetType: String, CaseIterable, Identifiable {
            case dog, cat
            var id: Self { self }
        }
    @State private var selectedSexe: Sexe = .male
    @State private var selectedType: PetType = .dog
    @State private var selectedBreed: String = ""
    @State private var petBirthDate: Date = Date()
    @State private var isAlergic: Bool = false
    @State private var kilos: Int = 0
    @State private var grams: Int = 0
    @State private var unitOfMeasure: String = "kg"
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
    
    var body: some View {
        VStack(spacing: screenWidth/16){
            HStack (spacing: screenWidth/16){
                VStack(spacing: 30){
                    ZStack {
                        
                        Image("dog-image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: screenWidth / 3, height: screenWidth / 3)
                            .clipShape(Circle())
                            .overlay(
                                Circle().stroke(Color.black, lineWidth: 4)
                            )
                        
                        Button(action: {
                            // Action to perform when the button is tapped
                            print(selectedSexe)
                        }) {
                            Image(systemName: "plus")
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
                VStack(alignment:.leading,spacing: 20){
                    Text("New Pet")
                        .font(.custom(customFont, size: 50))
                        .bold()
                        .foregroundColor(.black)
                    
                    
                    CustomTF(hint: "Enter your pet name", label:"Name", value: $value)
                        .padding(.top,30)
                    HStack{
                        typeSelection
                        Spacer()
                        sexeSelection
                    }
                    
                    Picker("Breed", selection: $selectedBreed) {
                        ForEach(breedOptions, id: \.self) { breed in
                            Text(breed)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(RoundedRectangle(cornerRadius:50)
                        .fill(Color.themeSecondary))
                    .shadow(radius: 1)
                    DatePicker(
                        "Birth Date",
                        selection: $petBirthDate,
                        displayedComponents: .date
                    )
                    .padding()
                    .background(Color.themeSecondary)
                    .cornerRadius(30)
                    .shadow(radius: 1)
                    HStack{
                        Text("Weight :")
                            .font(.custom(customFont, size: 20))
                           // .bold()
                            .foregroundColor(.black)
                        WeightPicker(kilos: $kilos, grams: $grams, unitOfMeasure: $unitOfMeasure)
                                            .frame(height: 150) // Adjust the height as needed
                                            .clipped()
                                            .padding(.vertical, 8)
                    }
                    
                    
                }
                
            }
            HStack{
                Button(action: {
                    
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.custom(customFont, size: 40))
                        .bold()
                    
                }
                .frame(maxWidth: 200)
                .padding()
                .background(Color.themeBlue)
                //.padding(.horizontal, 40)
                .cornerRadius(30)
            }
        }.padding()
            .padding(.horizontal,30)
    }
    private var typeSelection: some View {
        HStack {
           // Spacer()
            ForEach(PetType.allCases) { type in
                Button(action: {
                    selectedType = type
                }) {
                    Image(type.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80,height: 80)
                        //.background(Color.themeLightBlue)
                        .clipShape(Circle())
                        .overlay(
                            selectedType == type
                            ? Circle().stroke(Color.themeBlue, lineWidth: 4)
                            : Circle().stroke(.clear, lineWidth: 0)
                        )
                    
                }
                //Spacer()
            }
            
            
        }.padding()
    }
    private var sexeSelection: some View {
        HStack {
           // Spacer()
            ForEach(Sexe.allCases) { sexe in
                Button(action: {
                    selectedSexe = sexe
                }) {
                    Image(sexe.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80,height: 80)
                       // .background(Color.themeLightBlue)
                        .clipShape(Circle())
                        .overlay(
                            selectedSexe == sexe
                            ? Circle().stroke(Color.themeBlue, lineWidth: 4)
                            : Circle().stroke(.clear, lineWidth: 0)
                        )
                    
                }
               // Spacer()
            }
            
            
        }.padding()
    }
    private var medicalInfo: some View {
        VStack(alignment:.leading,spacing: 20){
            Text("Medical Informations")
                .font(.custom(customFont, size: 30))
               // .bold()
                .foregroundColor(.black)
     
            CustomToggle(label: "Neutered", isToggle: $isAlergic)
            CustomToggle(label: "Allergies", isToggle: $isAlergic)
            CustomToggle(label: "Sick", isToggle: $isAlergic)
            DatePicker(
                           "Last Vaccination Date",
                           selection: $petBirthDate,
                           displayedComponents: .date
                       )
                       .padding()
                       .background(Color.themeSecondary)
                       .cornerRadius(30)
                       .shadow(radius: 1)
                    
        }
    }
    
}

#Preview {
    AddNewPetForm()
}
