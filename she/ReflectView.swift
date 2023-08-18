//  Created by Kashvi on 8/16/23.

import Foundation
import SwiftUI

struct ReflectView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Image("background")
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Text("self-reflection")
                        .font(.title)
                        .padding(.top, -40)
                    Text("you will have the ability to assess your mood, energy, stress, focus, and sleep.")
                        .font(.body)
                        .padding()
                        .multilineTextAlignment(.center)
                    NavigationLink(
                        destination: ReflectionSurveyView(),
                        label: {
                            VStack {
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 10)
                                    .background(Color.white)
                                    .frame(width: 290, height: 250)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(Color.init(red: 0.1, green: 0.1, blue: 0.3))
                                    )
                                    .overlay(
                                        Text("august 18, 2023")
                                            .font(.title2)
                                            .foregroundColor(Color.white)
                                    )
                            }
                        }
                    )
                    .padding(.bottom)
                    Text("look at your past reflections here.")
                    NavigationLink(
                        destination: ReflectionArchiveView(),
                        label: {
                            VStack {
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 10)
                                    .background(Color.white)
                                    .frame(width: 250, height: 100)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(Color.init(red: 0.1, green: 0.1, blue: 0.3))
                                    )
                                    .overlay(
                                        Text("archive")
                                            .font(.title2)
                                            .foregroundColor(Color.white)
                                    )
                            }
                        }
                    )
                }
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

