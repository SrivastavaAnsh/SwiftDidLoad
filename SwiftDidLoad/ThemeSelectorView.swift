import SwiftUI

struct ThemeSelectorView: View {
    @AppStorage("selectedTheme") private var selectedTheme: String = Theme.green.rawValue
    @Environment(\.dismiss) private var dismiss
    
    @State private var activeTheme: Theme = .green
    @State private var isGridView: Bool = false
    @State private var hasTappedTheme: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        let showButton = !isGridView || hasTappedTheme
        
        ZStack {
            RadialGradient(
                colors: activeTheme.gradientColors,
                center: .top,
                startRadius: 0,
                endRadius: 600
            )
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.3), value: activeTheme)
            
            VStack(spacing: 0) {
                if !isGridView {
                    Spacer()
                    
                    TabView(selection: $activeTheme) {
                        ForEach(Theme.allCases) { theme in
                            ThemePreviewCard(theme: theme, isSelected: selectedTheme == theme.rawValue)
                                .tag(theme)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 500)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        ForEach(Theme.allCases) { theme in
                            Capsule()
                                .fill(activeTheme == theme ? theme.accentColor : Color.white.opacity(0.2))
                                .frame(width: activeTheme == theme ? 18 : 6, height: 6)
                                .animation(.spring(), value: activeTheme)
                        }
                    }
                    .padding(.bottom, 20)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(Theme.allCases) { theme in
                                ThemePreviewCard(
                                    theme: theme,
                                    isSelected: activeTheme == theme,
                                    size: CGSize(width: 150, height: 300)
                                )
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        activeTheme = theme
                                        hasTappedTheme = true
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, showButton ? 100 : 20)
                    }
                }
                
                if showButton {
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            selectedTheme = activeTheme.rawValue
                            alertMessage = "You have changed the theme to \(activeTheme.rawValue)."
                            showAlert = true
                        }
                    }) {
                        Text(selectedTheme == activeTheme.rawValue ? "Applied" : "Apply Theme")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                ZStack {
                                    
                                    // MARK: Base Background
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color(red: 0.15, green: 0.15, blue: 0.15),
                                                    Color(red: 0.08, green: 0.08, blue: 0.08)
                                                ],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                    
                                    // MARK: Internal Accent Gradient (covers almost entire button)
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: activeTheme.accentGradientColors,
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .mask(
                                            Capsule()
                                                .fill(
                                                    LinearGradient(
                                                        stops: [
                                                            .init(color: .white.opacity(0.08), location: 0.08),
                                                            .init(color: .white.opacity(0.15), location: 0.20),
                                                            .init(color: .white.opacity(0.28), location: 0.35),
                                                            .init(color: .white.opacity(0.48), location: 0.55),
                                                            .init(color: .white.opacity(0.72), location: 0.75),
                                                            .init(color: .white, location: 1.0)
                                                        ],
                                                        startPoint: .top,
                                                        endPoint: .bottom
                                                    )
                                                )
                                        )
                                    
                                    // MARK: Top Highlight
                                    Capsule()
                                        .strokeBorder(
                                            LinearGradient(
                                                colors: [
                                                    Color.white.opacity(0.12),
                                                    .clear
                                                ],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            ),
                                            lineWidth: 1
                                        )
                                    
                                    // MARK: Border
                                    Capsule()
                                        .stroke(
                                            Color.white.opacity(0.15),
                                            lineWidth: 1
                                        )
                                }
                            )
                            .shadow(
                                color: activeTheme.accentGradientColors.last!.opacity(0.25),
                                radius: 12,
                                x: 0,
                                y: 8
                            )
                            .padding(.horizontal, 32)
                    }
                    .disabled(selectedTheme == activeTheme.rawValue)
                    .opacity(selectedTheme == activeTheme.rawValue ? 0.6 : 1.0)
                    .animation(.easeInOut(duration: 0.2), value: selectedTheme)
                    .padding(.bottom, 16)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
            
            // Custom alert overlay
            if showAlert {
                // Dimmed background
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showAlert = false
                        }
                    }
                
                // Alert Card
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Text("Theme Changed")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(alertMessage)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 24)
                    
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showAlert = false
                        }
                    }) {
                        Text("Done")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(
                                ZStack {
                                    
                                    // MARK: Base Background
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    Color(red: 0.15, green: 0.15, blue: 0.15),
                                                    Color(red: 0.08, green: 0.08, blue: 0.08)
                                                ],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                    
                                    // MARK: Internal Accent Gradient (covers almost entire button)
                                    Capsule()
                                        .fill(
                                            LinearGradient(
                                                colors: activeTheme.accentGradientColors,
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .mask(
                                            Capsule()
                                                .fill(
                                                    LinearGradient(
                                                        stops: [
                                                            .init(color: .white.opacity(0.08), location: 0.08),
                                                            .init(color: .white.opacity(0.15), location: 0.20),
                                                            .init(color: .white.opacity(0.28), location: 0.35),
                                                            .init(color: .white.opacity(0.48), location: 0.55),
                                                            .init(color: .white.opacity(0.72), location: 0.75),
                                                            .init(color: .white, location: 1.0)
                                                        ],
                                                        startPoint: .top,
                                                        endPoint: .bottom
                                                    )
                                                )
                                        )
                                    
                                    // MARK: Top Highlight
                                    Capsule()
                                        .strokeBorder(
                                            LinearGradient(
                                                colors: [
                                                    Color.white.opacity(0.12),
                                                    .clear
                                                ],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            ),
                                            lineWidth: 1
                                        )
                                    
                                    // MARK: Border
                                    Capsule()
                                        .stroke(
                                            Color.white.opacity(0.15),
                                            lineWidth: 1
                                        )
                                }
                            )
                            .shadow(
                                color: activeTheme.accentGradientColors.last!.opacity(0.25),
                                radius: 8,
                                x: 0,
                                y: 4
                            )
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.vertical, 24)
                .frame(width: 280)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.10, green: 0.10, blue: 0.12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )
                )
                .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                .transition(.scale(scale: 0.9).combined(with: .opacity))
            }
        }
        .navigationTitle("Choose Theme")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isGridView.toggle()
                        hasTappedTheme = false
                    }
                }) {
                    Image(systemName: isGridView ? "inset.filled.rectangle.portrait" : "square.grid.2x2")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            if let current = Theme(rawValue: selectedTheme) {
                activeTheme = current
            }
        }
    }
}

struct ThemePreviewCard: View {
    let theme: Theme
    let isSelected: Bool
    var size: CGSize = CGSize(width: 220, height: 450)
    
    var body: some View {
        VStack(spacing: size.height * (16.0 / 450.0)) {
            // Miniature iPhone screen
            VStack(spacing: 0) {
                ZStack {
                    // Ambient radial gradient of the theme
                    RadialGradient(
                        colors: theme.gradientColors,
                        center: .top,
                        startRadius: 0,
                        endRadius: size.height * (240.0 / 450.0)
                    )
                    
                    VStack(spacing: 0) {
                        // Notch/Dynamic Island mockup
                        Capsule()
                            .fill(Color.black)
                            .frame(width: size.width * (60.0 / 220.0), height: size.height * (16.0 / 450.0))
                            .padding(.top, size.height * (10.0 / 450.0))
                        
                        // Header mockup (shows toolbar item like parent screen)
                        HStack {
                            Spacer()
                            Image(systemName: "person.fill")
                                .font(.system(size: size.width * (11.0 / 220.0)))
                                .foregroundColor(theme.accentColor)
                                .padding(size.width * (6.0 / 220.0))
                                .background(Color.white.opacity(0.08))
                                .clipShape(Circle())
                        }
                        .padding(.horizontal, size.width * (16.0 / 220.0))
                        .padding(.top, size.height * (8.0 / 450.0))
                        
                        Spacer()
                        
                        Spacer()
                        .padding(.horizontal, size.width * (14.0 / 220.0))
                        .frame(width: size.width * (150.0 / 220.0), height: size.height * (32.0 / 450.0))
                        .background(Color.black.opacity(0.65))
                        .cornerRadius(size.width * (16.0 / 220.0))
                        .overlay(
                            RoundedRectangle(cornerRadius: size.width * (16.0 / 220.0))
                                .stroke(Color.white.opacity(0.08), lineWidth: 0.5)
                        )
                        .padding(.bottom, size.height * (12.0 / 450.0))
                    }
                }
            }
            .frame(width: size.width, height: size.height)
            .cornerRadius(size.width * (32.0 / 220.0))
            .overlay(
                RoundedRectangle(cornerRadius: size.width * (32.0 / 220.0))
                    .stroke(isSelected ? theme.accentColor : Color.white.opacity(0.15), lineWidth: isSelected ? 3 : 1)
            )
            .shadow(color: isSelected ? theme.accentColor.opacity(0.2) : Color.black.opacity(0.3), radius: size.width * (12.0 / 220.0), x: 0, y: size.height * (6.0 / 450.0))
            
            // Theme Name
            Text(theme.rawValue)
                .font(.system(size.height >= 400 ? .headline : .subheadline, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(isSelected ? .white : .white.opacity(0.6))
        }
    }
}

#Preview {
    NavigationStack {
        ThemeSelectorView()
    }
}
