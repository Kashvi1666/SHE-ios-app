import SwiftUI
import Combine

struct AvatarView: View {
    @EnvironmentObject var avatarCustomizationManager: AvatarCustomizationManager

    var body: some View {
        ZStack {
            Image("background").ignoresSafeArea()
            VStack {
                Text("create your avatar")
                    .font(.title)
                    .foregroundColor(.white)
                    .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/-45.0/*@END_MENU_TOKEN@*/)
                //eyes button
                Button(action: {
                    avatarCustomizationManager.showEyeColorPicker.toggle()
                }) {
                    Text("eyes")
                }
                    .padding()
                    .popover(isPresented: $avatarCustomizationManager.showEyeColorPicker){
                        ColorPicker("pick eye color", selection: $avatarCustomizationManager.selectedEyeColor)
                        .padding()
                }
                //skin button
                Button(action: {
                    avatarCustomizationManager.showSkinColorPicker.toggle()
                }) {
                    Text("skin")
                }
                    .padding()
                    .popover(isPresented: $avatarCustomizationManager.showSkinColorPicker) {
                        ColorPicker("pick skin color", selection: $avatarCustomizationManager.selectedSkinColor)
                    .padding()
                }
                //display
                AvatarPreview(
                    skinColor: avatarCustomizationManager.skinColor,
                    eyeColor: avatarCustomizationManager.eyeColor
                )
                .frame(width: 200, height: 200)
            }
        }
        .navigationBarHidden(true)
    }
}

class AvatarCustomizationManager: ObservableObject {
    @Published var skinColor: Color = .black
    @Published var eyeColor: Color = .pink
    
    @Published var selectedSkinColor: Color = .black
    @Published var selectedEyeColor: Color = .pink
    
    @Published var showEyeColorPicker = false
    @Published var showSkinColorPicker = false
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
