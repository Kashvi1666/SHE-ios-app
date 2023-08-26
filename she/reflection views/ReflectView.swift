import Foundation
import SwiftUI

struct ReflectView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Image("background")
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("user's reflections")
                        .fontWeight(.light)
                        .font(.title)
                    NavigationLink(
                        destination: ReflectionSurveyView(),
                        label: {
                            VStack {
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: 302, height: 450)
                                    .cornerRadius(20)
                                    .overlay(
                                        Text("august 18 \n2023")
                                            .font(.title2)
                                            .foregroundColor(Color.white)
                                    )
                            }
                        }
                    )
                    .padding(.bottom, 92)
                    .padding()
                }
            }
        }
    }
    
    struct ReflectView_Previews: PreviewProvider {
        static var previews: some View {
            ReflectView()
        }
    }
}
