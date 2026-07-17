import SwiftUI

struct HomeView: View {
    @State private var showProfile = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Opal-style ambient green radial background
                RadialGradient(
                    colors: [Color(red: 12/255, green: 38/255, blue: 25/255), .black],
                    center: .top,
                    startRadius: 0,
                    endRadius: 600
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("Home Screen")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Ready for tomorrow")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showProfile = true
                    }) {
                        Image(systemName: "person.fill")
                            .foregroundColor(Color(red: 0.4, green: 0.9, blue: 0.7))
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                    }
                }
            }
            .sheet(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    HomeView()
}
