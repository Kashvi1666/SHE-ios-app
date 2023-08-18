import SwiftUI
import Foundation
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var contextColor
        @FetchRequest(
                entity: AvatarData.entity(), sortDescriptors: [ NSSortDescriptor(keyPath: \AvatarData.name, ascending: false) ])
    var avatars: FetchedResults<AvatarData>
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().tintColor = .black
        UIBarButtonItem.appearance().tintColor = .black
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("background").ignoresSafeArea()
                VStack(spacing: 20) {
                    Text(Date(), style: .time)
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        .offset(y: -10.0)
                    HStack{
                        AvatarPreview(skinColor: Color(avatars.first?.skin ?? ""), eyeColor: Color(avatars.first?.eyes ?? ""), size: 100)
                            .offset(x: -80, y: -20)
                        Text("hi \nname").font(.largeTitle).fontWeight(.semibold).multilineTextAlignment(.leading).offset(x: /*@START_MENU_TOKEN@*/-30.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    }
                    NavigationLink(destination: RadarView()) {
                        ButtonLabel(title: "radar")
                    }.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20.0)
                    NavigationLink(destination: RitualView()) {
                        ButtonLabel(title: "ritual")
                    }.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20.0)
                    NavigationLink(destination: ReflectView()) {
                        ButtonLabel(title: "reflect")
                    }.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20.0)
                    NavigationLink(destination: RoadmapView()) {
                        ButtonLabel(title: "roadmap")
                    }.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20.0)
                }
            }.navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
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
            if UserDefaults.standard.hasCompletedAvatarCustomization {
                ContentView()
            } else {
                FirstView()
            }
        }
    }
}
