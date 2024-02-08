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
        
        HStack (spacing: screenWidth/14){
            VStack{
            ZStack {
                
                Image("dog-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth / 2.7, height: screenWidth / 2.7)
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
                    .offset(x: screenWidth / 8, y: screenWidth / 7)
            }
                //Spacer()
        }
            VStack(alignment:.leading,spacing: 20){
                Text("New Pet")
                    .font(.custom(customFont, size: 50))
                    .bold()
                    .foregroundColor(.black)
                
                CustomTF(hint: "Enter your pet name", label:"Name", value: $value)
              /*  Picker("Type", selection: $selectedType) {
                    ForEach(PetType.allCases) { type in
                        
                     //Text(type.rawValue.capitalized)
                          //  .background(Color.themeBlue)
                        
                        Image(type.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 5,height: 5)
                            .clipShape(Circle())
                    }
                    
                }.background(Color.themeSecondary)
                .cornerRadius(30)
                .pickerStyle(SegmentedPickerStyle())
                .shadow(radius: 1)*/
                typeSelection
               // Form{
                    Picker("Breed", selection: $selectedBreed) {
                        ForEach(breedOptions, id: \.self) { breed in
                            Text(breed)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(RoundedRectangle(cornerRadius:50)
                        .fill(Color.themeSecondary))
                    .shadow(radius: 1)
                    
                    
               // }.scrollContentBackground(.hidden)
               //     .frame(height: 100)
                  
                DatePicker(
                               "Birth Date",
                               selection: $petBirthDate,
                               displayedComponents: .date
                           )
                           .padding()
                           .background(Color.themeSecondary)
                           .cornerRadius(30)
                           .shadow(radius: 1)
                
                  /*  Picker("Sexe", selection: $selectedSexe) {
                        ForEach(Sexe.allCases) { sexe in
                         Text(sexe.rawValue.capitalized)
                        }
                    }.background(Color.themeSecondary)
                    .cornerRadius(30)
                    .pickerStyle(SegmentedPickerStyle())
                    .shadow(radius: 1)
                      */
                sexeSelection
                        
            }
            
        }.padding()
    }
    private var typeSelection: some View {
        HStack {
            Spacer()
            ForEach(PetType.allCases) { type in
                Button(action: {
                    selectedType = type
                }) {
                    Image(type.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150,height: 150)
                        .background(Color.themeLightBlue)
                        .clipShape(Circle())
                        .overlay(
                            selectedType == type
                            ? Circle().stroke(Color.themeBlue, lineWidth: 4)
                            : Circle().stroke(.clear, lineWidth: 0)
                        )
                    
                }
                Spacer()
            }
            
            
        }.padding()
    }
    private var sexeSelection: some View {
        HStack {
            Spacer()
            ForEach(Sexe.allCases) { sexe in
                Button(action: {
                    selectedSexe = sexe
                }) {
                    Image(sexe.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150,height: 150)
                       // .background(Color.themeLightBlue)
                        .clipShape(Circle())
                        .overlay(
                            selectedSexe == sexe
                            ? Circle().stroke(Color.themeBlue, lineWidth: 4)
                            : Circle().stroke(.clear, lineWidth: 0)
                        )
                    
                }
                Spacer()
            }
            
            
        }.padding()
    }
    
}

#Preview {
    AddNewPetForm()
}
