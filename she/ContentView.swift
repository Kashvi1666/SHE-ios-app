import SwiftUI
import Foundation
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: AvatarData.entity(),
        sortDescriptors: [ NSSortDescriptor(keyPath: \AvatarData.name, ascending: false) ]
    ) var avatars: FetchedResults<AvatarData>

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = .black
        UIBarButtonItem.appearance().tintColor = .black
    }

    var body: some View {
        NavigationView {
            ZStack {
                Image("background").ignoresSafeArea()
                VStack(spacing: 20) {
                    Text(Date(), style: .time)
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        .offset(y: -60.0)

                    HStack {
                        AvatarPreview(skinColor: Color(avatars.first?.skin ?? ""), eyeColor: Color(avatars.first?.eyes ?? ""), size: 100)
                            .offset(x: -20, y: -10)
                        
                        if let userName = avatars.first?.name, !userName.isEmpty {
                            Text("hi, \(userName)")
                        } else {
                            Text("hi, user")
                        }
                    }
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    
                    NavigationLink(destination: RadarView()) {
                        ButtonLabel(title: "radar")
                    }.offset(y: 20.0)
                    NavigationLink(destination: RitualView()) {
                        ButtonLabel(title: "ritual")
                    }.offset(y: 20.0)
                    NavigationLink(destination: ReflectView()) {
                        ButtonLabel(title: "reflect")
                    }.offset(y: 20.0)
                    NavigationLink(destination: RoadmapView()) {
                        ButtonLabel(title: "roadmap")
                    }.offset(y: 20.0)
                }
            }.navigationBarBackButtonHidden(true)
        }
        .onAppear {
            print("Total avatars fetched: \(avatars.count)")
            print("First avatar's name: \(avatars.first?.name ?? "No name")")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ButtonLabel: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.title)
            
            .fontWeight(.light)
            .foregroundColor(.white)
            .frame(width: 320, height: 100)
            .background(Color.black)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.white, lineWidth: 1)
                    
            ).shadow(color: Color.black.opacity(0.4), radius: 20)
    }
}

struct RootView: View {
    var body: some View {
        Group {
            if UserDefaults.standard.bool(forKey: "hasCompletedAvatarCustomization") {
                ContentView()
            } else {
                FirstView()
            }
        }
    }
}
