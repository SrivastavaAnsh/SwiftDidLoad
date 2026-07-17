import SwiftUI

struct CartView: View {
    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.green.rawValue
    
    private var currentTheme: Theme {
        Theme(rawValue: selectedTheme) ?? .green
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(
                    colors: currentTheme.gradientColors,
                    center: .top,
                    startRadius: 0,
                    endRadius: 600
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Cart Screen")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person.fill")
                            .foregroundColor(currentTheme.accentColor)
                    }
                }
            }
        }
    }
}

#Preview {
    CartView()
}
