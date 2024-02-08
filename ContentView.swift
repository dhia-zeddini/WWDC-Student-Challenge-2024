import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.themePrimary
              .ignoresSafeArea()
            AddNewPetForm()
        }
      
    }
}
