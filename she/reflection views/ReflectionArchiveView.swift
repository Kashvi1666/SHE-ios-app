import SwiftUI
struct ReflectionArchive: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ReflectionArchiveView()
                    .padding()
            }
        }
    }
}
struct ReflectionArchiveView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("archive")
                .font(.title)
                .foregroundColor(.black)
            ForEach(0..<10) { index in
                NavigationLink(destination: ReflectionPastSurvey()) {
                    RectangleView(index: index)
                }
            }
        }
    }
}
struct RectangleView: View {
    var index: Int
    var body: some View {
        VStack {
            Rectangle()
                .stroke(Color.white, lineWidth: 2)
                .background(Color.init(red: 0.1, green: 0.1, blue: 0.3))
                .frame(width: 340, height: 40)
                .cornerRadius(10)
                .overlay(
                    Text("Entry \(index + 1)")
                        .font(.headline)
                        .foregroundColor(.white)
                )
        }
    }
}
struct ReflectionArchive_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionArchive()
    }
}
