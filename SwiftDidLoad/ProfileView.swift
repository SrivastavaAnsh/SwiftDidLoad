import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.green.rawValue
    
    private var currentTheme: Theme {
        Theme(rawValue: selectedTheme) ?? .green
    }
    
    var body: some View {
        ZStack {
            RadialGradient(
                colors: currentTheme.gradientColors,
                center: .top,
                startRadius: 0,
                endRadius: 600
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Profile Header (outside list)
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.05))
                            .frame(width: 110, height: 110)
                            .overlay(Circle().stroke(Color.white.opacity(0.1), lineWidth: 1))
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(currentTheme.accentColor)
                    }
                    .padding(.top, 40)
                    
                    Text("Ansh Srivastava")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                // Theme Navigation Row (inside List)
                List {
                    NavigationLink(destination: ThemeSelectorView()) {
                        HStack {
                            Image(systemName: "paintpalette.fill")
                                .foregroundColor(currentTheme.accentColor)
                                .font(.body)
                            
                            Text("Theme")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(currentTheme.rawValue)
                                .font(.system(.subheadline, design: .rounded))
                                .foregroundColor(.white.opacity(0.5))
                        }
                    }
                    .listRowBackground(Color.white.opacity(0.05))
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .frame(height: 50)
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    // Action for settings
                }) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.white)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    ProfileView()
}
