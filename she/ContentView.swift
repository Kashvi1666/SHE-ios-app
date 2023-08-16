import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background").ignoresSafeArea()
                VStack(spacing: 20) {
                    Text(Date(), style: .time)
                        .font(.largeTitle)
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        .offset(y: -110.0)
                    NavigationLink(destination: RadarView()) {
                        ButtonLabel(title: "radar")
                    }.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 80.0)
                    NavigationLink(destination: RitualView()) {
                        ButtonLabel(title: "ritual")
                    }.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 80.0)
                    NavigationLink(destination: ReflectView()) {
                        ButtonLabel(title: "reflect")
                    }.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 80.0)
                    NavigationLink(destination: RoadmapView()) {
                        ButtonLabel(title: "roadmap")
                    }.offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 80.0)
                }
            }
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
