import SwiftUI

struct MainTabView: View {
    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.green.rawValue
    
    private var currentTheme: Theme {
        Theme(rawValue: selectedTheme) ?? .green
    }
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                HomeView()
            }
            Tab("Cart", systemImage: "cart") {
                CartView()
            }
        }
        .tint(currentTheme.accentColor)
    }
}

#Preview {
    MainTabView()
}
