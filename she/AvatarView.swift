import SwiftUI
import Combine

struct AvatarView: View {
    @EnvironmentObject var avatarCustomizationManager: AvatarCustomizationManager

 
    var body: some View {
        ZStack {
            Image("background").ignoresSafeArea()
            VStack {
                Text("Create Your Avatar")
                    .font(.title)
                    .foregroundColor(.white)
                
                ColorButton(title: "Eyes", color: .black, action: {
                    avatarCustomizationManager.showEyeColorPicker.toggle()
                })
                .padding()
                .offset(x: -45.0, y: 10)
                
                ColorButton(title: "Skin", color: .black, action: {
                    avatarCustomizationManager.showSkinColorPicker.toggle()
                })
                .padding()
                .offset(x: 45.0, y: -80.0)
                
                AvatarPreview(
                    skinColor: avatarCustomizationManager.skinColor,
                    eyeColor: avatarCustomizationManager.eyeColor
                )
                .frame(width: 200, height: 200)
            }
        }
        .navigationBarHidden(true)
        .popover(isPresented: $avatarCustomizationManager.showEyeColorPicker) {
            ColorPickerPopover(colors: [.blue, .green, .brown, .gray], selectedColor: $avatarCustomizationManager.selectedEyeColor)
                .onDisappear {
                    avatarCustomizationManager.applyColors()
                }
        }
        .popover(isPresented: $avatarCustomizationManager.showSkinColorPicker) {
            ColorPickerPopover(colors: [.pink, .purple, .red, .orange], selectedColor: $avatarCustomizationManager.selectedSkinColor)
                .onDisappear {
                    avatarCustomizationManager.applyColors()
                }
        }
    }
}

struct ColorPickerPopover: View {
    let colors: [Color]
    @Binding var selectedColor: Color
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        self.selectedColor = color
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .padding()
        }
        background(Color.black)
        .cornerRadius(10)
        .padding()
    }
}


struct ColorButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.white, lineWidth: 2)
                )
        }
    }
}

class AvatarCustomizationManager: ObservableObject {
    @Published var skinColor: Color = .black
    @Published var eyeColor: Color = .pink
    
    @Published var selectedSkinColor: Color = .black
    @Published var selectedEyeColor: Color = .pink
    
    @Published var showEyeColorPicker = false
    @Published var showSkinColorPicker = false
    
    func applyColors() {
        skinColor = selectedSkinColor
        eyeColor = selectedEyeColor
    }
}
struct AvatarPreview: View {
    let skinColor: Color
    let eyeColor: Color
    
    var body: some View {
        ZStack {
            //avatar build
            RoundedRectangle(cornerRadius: 80)
                .fill(skinColor)
                .frame(width: 200, height: 200)
                .shadow(color: Color.white.opacity(0.4), radius: 14)
            Capsule()
                .fill(skinColor)
                .frame(width: 140, height: 200)
                .offset(y: 90)
            RoundedRectangle(cornerRadius: 70)
                .fill(skinColor)
                .frame(width: 30, height: 80)
                .offset(x: -70, y: 120)
            RoundedRectangle(cornerRadius: 70)
                .fill(skinColor)
                .frame(width: 30, height: 80)
                .offset(x: 70, y: 120)
            Circle()
                .fill(RadialGradient(
                    gradient: Gradient(colors: [eyeColor, skinColor]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 60
                ))
                .frame(width: 60, height: 60)
                .offset(x: -40, y: -2)
            Circle()
                .fill(RadialGradient(
                    gradient: Gradient(colors: [eyeColor, skinColor]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 60
                ))
                .frame(width: 60, height: 60)
                .offset(x: 40, y: -2)
            Path { path in
                path.move(to: CGPoint(x: -50, y: -140))
                path.addQuadCurve(to: CGPoint(x: 7, y: -100), control: CGPoint(x: 20, y: -180))
            }
            .stroke(LinearGradient(gradient: Gradient(colors: [skinColor, .white, skinColor]), startPoint: .top, endPoint: .bottom), lineWidth: 14)
            .frame(width: 40, height: 80)
            .offset(x: 20, y: 45)
            .overlay(
                Circle()
                    .fill(RadialGradient(
                        gradient: Gradient(colors: [skinColor, Color.white]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 80
                    ))
                    .frame(width: 40, height: 40)
                    .offset(x: -40, y: -140)
                    .shadow(color: Color.white.opacity(0.8), radius: 30)
                    .shadow(color: Color.white.opacity(0.8), radius: 30)
                    .shadow(color: skinColor.opacity(0.8), radius: 20)
            )
        }
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
            .environmentObject(AvatarCustomizationManager())
    }
}
