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
                    Text("user's reflections")
                        .fontWeight(.light)
                        .font(.title)
                    NavigationLink(
                        destination: ReflectionSurveyView(),
                        label: {
                            VStack {
                                Rectangle()
                                    .background(Color.black)
                                    .frame(width: 302, height: 450)
                                    .cornerRadius(20)
                                    .overlay(
                                        Text("august 18 \n2023")
                                            .font(.title2)
                                            .foregroundColor(Color.white)
                                    )
                                    .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 40.0)
                            }
                        }
                    )
                    .padding(.bottom)
                    NavigationLink(
                        destination: ReflectionArchiveView(),
                        label: {
                            VStack {
                                Rectangle()
                                    .background(Color.black)
                                    .frame(width: 300, height: 100)
                                    .cornerRadius(20)
                                    .overlay(
                                        Text("archive")
                                            .font(.title2)
                                            .foregroundColor(Color.white)
                            )
                                    .offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 45.0)
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

