import SwiftUI
struct ReflectionSurveyView: View {
    @State private var moodRating: Double = 1
    @State private var energyRating: Double = 1
    @State private var stressRating: Double = 1
    @State private var focusRating: Double = 1
    @State private var sleepRating: Double = 1
    @State private var journalText: String = ""
    @State private var isCycling: Bool = false
    
    var body: some View {
        ZStack {
            Image("background").ignoresSafeArea()
            ScrollView {
                VStack(spacing: 15) {  
                    Text("august 18, 2023")
                        .font(.caption)   
                        .padding([.top, .bottom], 8)  
                    
                    RatingSlider(value: $moodRating, title: "mood")
                    RatingSlider(value: $energyRating, title: "energy")
                    RatingSlider(value: $stressRating, title: "stress")
                    RatingSlider(value: $focusRating, title: "focus")
                    RatingSlider(value: $sleepRating, title: "sleep")
                    
                    Text("cycle")
                        .font(.caption)  
                        .multilineTextAlignment(.center)
                    
                    Toggle("", isOn: $isCycling)
                        .labelsHidden()
                        .padding(.bottom, 8)
                    
                    Text("journal")
                        .font(.caption)  
                        .multilineTextAlignment(.center)
                    
                    TextEditor(text: $journalText)
                        .frame(height: 80)  
                        .padding(8)         
                        .background(Color.init(red: 0.1, green: 0.1, blue: 0.3))
                    
                }
                .padding([.leading, .trailing], 8)  
            }
        }
    }
    struct RatingSlider: View {
        @Binding var value: Double
        var title: String
        
        var body: some View {
            VStack {
                Text(title)
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Slider(value: $value, in: 1...10, step: 1)
                    .padding(.horizontal)
                    .accentColor(Color.init(red: 0.1, green: 0.1, blue: 0.3))
                
                Text("\(Int(value))")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top)
            }
        }
    }
    struct ReflectionSurveyView_Previews: PreviewProvider {
        static var previews: some View {
            ReflectionSurveyView()
        }
    }
}
