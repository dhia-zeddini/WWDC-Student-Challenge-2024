import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color.themePrimary
                    .ignoresSafeArea()
                HomeView()
            }
        }
    }
}
