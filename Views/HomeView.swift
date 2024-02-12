//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 8/2/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = BottomPetsListViewModel()
    @State var selectedPet: Pet?
    var body: some View {
        VStack {
            Text(selectedPet?.name ?? "name")
            Text(selectedPet?.type ?? "type")
            Text(selectedPet?.breed ?? "breed")
                   
               
               Spacer() 
               
            BottomPetsList(selectedPetBinding: $selectedPet)
           }
    }
}

#Preview {
    HomeView()
}
