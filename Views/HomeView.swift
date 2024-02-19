//
//  SwiftUIView.swift
//  
//
//  Created by Zeddin Dhia on 8/2/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var isSideMenuVisible: Bool = false
    /****************$$$$$$*/
    let screenWidth:CGFloat=Constants.screenWidth
    let screenHeight:CGFloat=Constants.screenHeight
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateFormat = "dd-MM-yyyy"
       return formatter
    }()
    @StateObject private var viewModel = BottomPetsListViewModel()
    @State var selectedPet: Pet?
    
    @State private var draggableWidgets: [CustomWidgetModel] = [MockData.taskOne,MockData.taskTwo,MockData.taskThee,MockData.taskFour]
    @State private var dropWidgets: [CustomWidgetModel] = []
    @State private var isDropTarget = false
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false){
                HStack(spacing: screenWidth/16){
                    petInfoSection
                        .padding(.top,30)
                    //Spacer()
                    DropArea(dropWidgets: dropWidgets,isTargeted: isDropTarget)
                        .padding()
                        .dropDestination(for: CustomWidgetModel.self){droppedWidgets, location in
                          let totalWidgets = dropWidgets + droppedWidgets
                            dropWidgets = Array(totalWidgets.uniqued())
                            return true
                        }isTargeted: { isTargeted in
                            isDropTarget = isTargeted
                        }
                    
          
                    
                }.padding(.horizontal)
                
            }
               Spacer()
               
            BottomPetsList(selectedPetBinding: $selectedPet)
            
           }.overlay(
            SideMenu(isVisible: $isSideMenuVisible, draggableWidgets: draggableWidgets)
             //   .frame(width: screenWidth/3,alignment: .leading)
                
        )
           .gesture(dragGesture)
           .onTapGesture {
               withAnimation {
                   isSideMenuVisible = false
               }
           }
    }
    private var petInfoSection: some View {
        VStack {
            Image(uiImage: viewModel.loadImageFromPath(selectedPet?.imagePath))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
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
        .frame(width: screenWidth / 2.7)
    }
    private var dragGesture: some Gesture {
        DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        isSideMenuVisible = false
                    }
                } else if $0.translation.width > 100 {
                    withAnimation {
                        isSideMenuVisible = true
                    }
                }
            }
    }

}
struct DropArea: View {
    let columnLayout = Array(repeating:GridItem() , count: 2)
    let dropWidgets: [CustomWidgetModel]
    let isTargeted: Bool
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(maxWidth: .infinity)
                .foregroundColor(isTargeted ? .teal.opacity(0.15) : Color(.clear))
            if dropWidgets.isEmpty{
                Text("Failed to create 0x88 image slot (alpha=1 wide=1) (client=0xac3b36ab) [0x5 (os/kern) failure]")
                    .font(.custom(Constants.customFont, size: 40))
                    .bold()
                
            }else{
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columnLayout, spacing: 36) {
                        ForEach(dropWidgets, id: \.id) { widget in
                            CustomWidget(draggableWidget: widget )
                               // .padding(.top, 70)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

