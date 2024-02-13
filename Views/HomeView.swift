//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 8/2/2024.
//

import SwiftUI

struct HomeView: View {
    let screenWidth:CGFloat=Constants.screenWidth
    let screenHeight:CGFloat=Constants.screenHeight
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "dd-MM-yyyy"
       return formatter
    }()
    @StateObject private var viewModel = BottomPetsListViewModel()
    @State var selectedPet: Pet?
    var body: some View {
        
        VStack {
            ScrollView(showsIndicators: false){
                HStack(spacing: screenWidth/16){
                    VStack(spacing: screenWidth/16){
                        petInfoSectionn
                            .blur(radius: 4)
                        petInfoSectionn
                            .blur(radius: 4)
                        
                    }
                    
                    petInfoSection
                        .padding(.top,30)
                    VStack(spacing: screenWidth/16){
                        petInfoSectionn
                            .blur(radius: 4)
                        petInfoSectionn
                            .blur(radius: 4)
                        
                    }
                    
                }.padding(.horizontal)
                
            }
               Spacer()
               
            BottomPetsList(selectedPetBinding: $selectedPet)
           }
    }
    private var petInfoSection: some View {
        VStack {
            Image(uiImage: viewModel.loadImageFromPath(selectedPet?.imagePath))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    //.cornerRadius(30)
                   // .padding()
            
            HStack{
                VStack(spacing: 10){
                    Text(selectedPet?.name ?? "Name")
                        .font(.custom(Constants.customFont, size: 40))
                        .bold()
                    
                    Text(selectedPet?.breed ?? "Breed")
                        .font(.custom(Constants.customFont, size: 20))
                }.padding(.horizontal)
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                HStack{
                    
                    Text(selectedPet?.weight ?? "weight")
                        .font(.custom(Constants.customFont, size: 20))
                }
                .padding()
                .background(.white)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 30,
                            bottomLeadingRadius: 30,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                    .shadow(radius: 0.5)
            }
            VStack(spacing: 20){
                HStack{
                    Text("Born in: ")
                        .font(.custom(Constants.customFont, size: 30))
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    Text(selectedPet?.birthDate != nil ? dateFormatter.string(from: selectedPet!.birthDate) : "Unknown")
                        .font(.custom(Constants.customFont, size: 20))
                }
                HStack{
                    Text("Allergic: ")
                        .font(.custom(Constants.customFont, size: 30))
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    Text(selectedPet?.isAllergic ?? false ? "Yes" : "No")
                        .font(.custom(Constants.customFont, size: 20))
                }
                HStack{
                    Text("Neutered: ")
                        .font(.custom(Constants.customFont, size: 30))
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    Text(selectedPet?.isNeutered ?? false ? "Yes" : "No")
                        .font(.custom(Constants.customFont, size: 20))
                }
                Image(selectedPet?.sexe ?? "male")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding()
                    .background(Color.themeSecondary)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    .offset(x: 0, y: screenWidth / 80)
            }.padding(.horizontal)
                .padding(.bottom,30)
           
        }
        .background(.white)
        .cornerRadius(30)
        .shadow(radius: 1)
        //.frame(width: screenWidth / 3)
    }

    private var petInfoSectionn: some View {
        VStack(alignment: .center) {
            ZStack {
                VStack {
                    Image("dog-image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(30)
                    
                    VStack{
                        HStack{
                            VStack(spacing: 10){
                                Text(selectedPet?.name ?? "Name")
                                    .font(.custom(Constants.customFont, size: 30))
                                    .bold()
                                
                                Text(selectedPet?.breed ?? "Breed")
                                    .font(.custom(Constants.customFont, size: 20))
                            }.padding(.horizontal)
                            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                            HStack{
                                
                                Text("10.5 Kg")
                                    .font(.custom(Constants.customFont, size: 20))
                            }
                            .padding()
                            .background(.white)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 30,
                                        bottomLeadingRadius: 30,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 0
                                    )
                                )
                                .shadow(radius: 0.5)
                        }
                    }.padding(.top,30)
                       // .padding(.horizontal)
                        .background(.white)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 30,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 30
                            )
                        )
                        .shadow(radius: 2)
                }
                    Image("male")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(Color.themeSecondary)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                        .offset(x: 0, y: screenWidth / 80)
            }
            .padding(.top,30)
            

            
        }
        .padding(.horizontal)
            .background(.white)
            .cornerRadius(30)
            .shadow(radius: 5)
          //  .frame(width: screenWidth / 3)
            
    }

}



#Preview {
    HomeView()
}
