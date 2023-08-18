import SwiftUI
struct ReflectionPastSurvey: View {
    var body: some View {
        VStack {
            Text("past survey")
                .font(.title)
                .foregroundColor(.black)
            
            Rectangle()
                .foregroundColor(Color.init(red: 0.1, green: 0.1, blue: 0.3))
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .overlay(
                    Text("Your Content Here")
                        .font(.headline)
                        .foregroundColor(.white)
                )
        }
        .padding()
    }
}
struct ReflectionPastSurvey_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionPastSurvey()
    }
}
