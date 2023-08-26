import SwiftUI
import CoreData
import UIKit

extension UserDefaults {
    var hasCompletedAvatarCustomization: Bool {
        get { return bool(forKey: "HasCompletedAvatarCustomization") }
        set { setValue(newValue, forKey: "HasCompletedAvatarCustomization") }
    }
}

extension Color {
    init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let hexSanitizedUppercased = hexSanitized.uppercased()
        let hex = hexSanitizedUppercased.starts(with: "#") ? String(hexSanitizedUppercased.dropFirst()) : hexSanitizedUppercased

        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(UIColor(red: red, green: green, blue: blue, alpha: 1.0))
    }

    var hex: String {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return String(format: "#%02X%02X%02X", Int(red * 255.0), Int(green * 255.0), Int(blue * 255.0))
    }
}
class AvatarCustomizationManager: ObservableObject {
    @Published var name: String = ""
    @Published var skinColor: Color = .black
    @Published var eyeColor: Color = .pink
    @Published var selectedSkinColor: Color = .black
    @Published var selectedEyeColor: Color = .pink
    @Published var showEyeColorPicker = false
    @Published var showSkinColorPicker = false
    
    let eyeColors: [Color] = [.indigo, .orange, .brown, .gray]
    let skinColors: [Color] = [.pink, .purple, .red, .black]
    
    private var moc: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.moc = context
        fetchData()
    }
    
    func fetchData() {
        let request = NSFetchRequest<AvatarData>(entityName: "AvatarData")
        do {
            let results = try moc.fetch(request)
            if let avatar = results.first {
                DispatchQueue.main.async {
                    self.name = avatar.name ?? ""
                    if let skinHex = avatar.skin {
                        self.skinColor = Color(hex: skinHex)
                        self.selectedSkinColor = Color(hex: skinHex)
                    }
                    if let eyeHex = avatar.eyes {
                        self.eyeColor = Color(hex: eyeHex)
                        self.selectedEyeColor = Color(hex: eyeHex)
                    }
                }
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func saveData() {
        let avatar = AvatarData(context: moc)
        avatar.name = self.name
        avatar.skin = self.skinColor.hex
        avatar.eyes = self.eyeColor.hex
        
        
        do {
            try moc.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    func applyColors() {
        skinColor = selectedSkinColor
        eyeColor = selectedEyeColor
        UserDefaults.standard.hasCompletedAvatarCustomization = true
        
        let request = NSFetchRequest<AvatarData>(entityName: "AvatarData")
        let results: [AvatarData]
        do {
            results = try moc.fetch(request)  // Changed contextColor to moc here
        } catch {
            print(error)
            return
        }
        
        let updateAvatar = results.isEmpty ? AvatarData(context: moc) : results[0]  // And here
        
        updateAvatar.skin = skinColor.hex
        updateAvatar.eyes = eyeColor.hex
        updateAvatar.name = name
        
        do {
            try moc.save()  // And here too
        } catch {
            print(error)
        }
    }
}

struct AvatarView: View {
    @StateObject var avatarCustomizationManager = AvatarCustomizationManager(context: PersistenceController.shared.container.viewContext)
    @State private var isNextButtonTapped = false
    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .ignoresSafeArea()

                VStack {
                    Text("Create Your Avatar")
                        .font(.title)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .offset(y: -78.0)
                    ZStack {
                        if avatarCustomizationManager.name.isEmpty {
                            Text("name")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        TextField("", text: $avatarCustomizationManager.name)
                            .padding(.horizontal, 10)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .accentColor(.white)
                            .autocapitalization(.none)
                    }
                        .frame(width: 200.0, height: 36.0)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                        .offset(y: -70.0)
                    HStack {
                        ColorButton(title: "eyes", action:
                                        {avatarCustomizationManager.showEyeColorPicker.toggle()})
                        .padding()
                        .offset(y: -70.0)

                        ColorButton(title: "skin", action:
                                        {avatarCustomizationManager.showSkinColorPicker.toggle()})
                        .padding()
                        .offset(y: -70.0)}
                    AvatarPreview(skinColor: avatarCustomizationManager.selectedSkinColor,
                                  eyeColor: avatarCustomizationManager.selectedEyeColor)
                        .frame(width: 200, height: 200)
                    Button(action: {
                        avatarCustomizationManager.applyColors()
                        isNextButtonTapped = true
                    }) {
                        Text("next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.white, lineWidth: 1))
                    }
                        .padding()
                        .offset(y: 110.0)
                    NavigationLink("", destination: ContentView(), isActive: $isNextButtonTapped)
                        .opacity(0)
                        .navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                }
            }
            .environmentObject(avatarCustomizationManager)
        }
        .popover(isPresented: $avatarCustomizationManager.showEyeColorPicker) {
            ColorPickerPopover(colors: avatarCustomizationManager.eyeColors, selectedColor: $avatarCustomizationManager.selectedEyeColor)
        }
        .popover(isPresented: $avatarCustomizationManager.showSkinColorPicker) {
            ColorPickerPopover(colors: avatarCustomizationManager.skinColors, selectedColor: $avatarCustomizationManager.selectedSkinColor)
        }
    }
}

struct ColorPickerPopover: View {
    @EnvironmentObject var avatarCustomizationManager: AvatarCustomizationManager
    let colors: [Color]
    @Binding var selectedColor: Color
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        selectedColor = color
                        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 60, height: 60)
                    }
                }
            }.padding()
        }.background(Color.white).cornerRadius(10).padding()
        
    }
}


struct ColorButton: View {
    let title: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.black)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.white, lineWidth: 1)
                )
        }
    }
}


//avatar build
struct AvatarPreview: View {
    var skinColor: Color
    var eyeColor: Color
    @EnvironmentObject var avatarCustomizationManager: AvatarCustomizationManager
    var size: CGFloat = 200
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 80)
                .fill(skinColor)
                .frame(width: size, height: size)
                .shadow(color: Color.white.opacity(0.4), radius: 14)
            Capsule()
                .fill(skinColor)
                .frame(width: size * 0.7, height: size)
                .offset(y: 90)
            RoundedRectangle(cornerRadius: 70)
                .fill(skinColor)
                .frame(width: size * 0.15, height: size * 0.4)
                .offset(x: -70, y: 120)
            RoundedRectangle(cornerRadius: 70)
                .fill(skinColor)
                .frame(width: size * 0.15, height: size * 0.4)
                .offset(x: 70, y: 120)
            Circle()
                .fill(RadialGradient(
                    gradient: Gradient(colors: [eyeColor, skinColor]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 60
                ))
                .frame(width: size * 0.3, height: size * 0.3)
                .offset(x: -40, y: -2)
                .overlay(Circle().stroke(Color.white, lineWidth: 0.7).offset(x: -40, y: -2))
            Circle()
                .fill(RadialGradient(
                    gradient: Gradient(colors: [eyeColor, skinColor]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 60
                ))
                .frame(width: size * 0.3, height: size * 0.3)
                .offset(x: 40, y: -2)
                .overlay(Circle().stroke(Color.white, lineWidth: 0.7).offset(x: 40, y: -2))
            Path { path in
                path.move(to: CGPoint(x: -50, y: -140))
                path.addQuadCurve(to: CGPoint(x: 7, y: -100), control: CGPoint(x: 20, y: -180))
            }
            .stroke(LinearGradient(gradient: Gradient(colors: [skinColor, .white, skinColor]), startPoint: .top, endPoint: .bottom), lineWidth: 14)
            .frame(width: size * 0.2, height: size * 0.4)
            .offset(x: 20, y: 45)
            .overlay(
                Circle()
                    .fill(RadialGradient(
                        gradient: Gradient(colors: [skinColor, Color.white]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 80
                    ))
                    .frame(width: size * 0.2, height: size * 0.2)
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
            .environmentObject(AvatarCustomizationManager(context: PersistenceController.shared.container.viewContext))
    }
}
