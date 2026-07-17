import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Opal-style ambient green gradient background
                RadialGradient(
                    colors: [Color(red: 12/255, green: 38/255, blue: 25/255), .black],
                    center: .top,
                    startRadius: 0,
                    endRadius: 600
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // Profile Image / Hexagon shape
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.05))
                            .frame(width: 110, height: 110)
                            .overlay(Circle().stroke(Color.white.opacity(0.1), lineWidth: 1))
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color(red: 0.4, green: 0.9, blue: 0.7))
                    }
                    .padding(.top, 40)
                    
                    Text("Phosgenite0400")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Stats Grid
                    HStack(spacing: 20) {
                        StatView(value: "0", label: "FOCUS HOURS", image: "hourglass")
                        StatView(value: "0", label: "DAY STREAK", image: "flame.fill")
                        StatView(value: "39%", label: "GLOBAL RANK", image: "chart.bar.fill")
                    }
                    .padding(.vertical)
                    
                    Spacer()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        // Action for settings
                    }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}

struct StatView: View {
    let value: String
    let label: String
    let image: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(.white.opacity(0.8))
                .frame(height: 30)
            
            Text(value)
                .font(.system(.title3, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(label)
                .font(.system(.caption2, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ProfileView()
}
