//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 10/2/2024.
//

import SwiftUI

struct BottomPetsList: View {
    @StateObject private var viewModel = BottomPetsListViewModel()
        @State var selectedPet: Pet?
        @State var showAddNewPetForm: Bool = false
        let iconSize: CGFloat = 120

        var body: some View {
            VStack {
               if (viewModel.pets.count > 0 ){
                    HStack(spacing: 10) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 40) {
                                ForEach(viewModel.pets, id: \.self) { pet in
                                    PetButton(pet: pet, selectedPet: $selectedPet, iconSize: iconSize)
                                }
                            }
                            .padding()
                        }
                        
                        newPetBtn
                    }
                    .padding()
                    .padding(.bottom, 80)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                    .frame(height: 100)
                    .shadow(radius: 2)
                } else {
                    HStack {
                        Text("No pets available.")
                        Spacer()
                        newPetBtn
                    }.padding()
                        .padding(.bottom, 80)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
                        .frame(height: 100)
                        .shadow(radius: 2)
                }
            }
            .onAppear {
                viewModel.fetchPets()
            }
            NavigationLink(destination: AddNewPetForm(), isActive: $showAddNewPetForm) {
                      EmptyView()
                  }
                 // .isDetailLink(false)
        }

        private func PetButton(pet: Pet, selectedPet: Binding<Pet?>, iconSize: CGFloat) -> some View {
            Button(action: {
                selectedPet.wrappedValue = pet
            }) {
                VStack {
                    // Assuming you have a method to convert imagePath to UIImage
                    Image(uiImage: viewModel.loadImageFromPath(pet.imagePath))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: iconSize, height: iconSize)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(selectedPet.wrappedValue == pet ? Color.blue : .clear, lineWidth: 4)
                        )
                    Text(pet.name )
                        .font(.custom(Constants.customFont, size: 30))
                        .foregroundColor(.black)
                }
            }
        }

        private var newPetBtn: some View {
            VStack {
                Button(action: {
                    showAddNewPetForm = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: iconSize, height: iconSize)
                        .background(.white)
                        .foregroundColor(.blue)
                        .clipShape(Circle())
                }
                
                Text("New")
                    .font(.custom(Constants.customFont, size: 30))
                    .foregroundColor(.black)
            }
            .padding()
        }
    }


#Preview {
    HomeView()
}
