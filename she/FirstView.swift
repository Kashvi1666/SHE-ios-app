// created by Kashvi on 8/14/23.

import SwiftUI
import Foundation

struct FirstView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("background").ignoresSafeArea()
                VStack {
                    Text("S.H.E")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .offset(x: 0.0, y: -60.0)
                        .dynamicTypeSize(.xxxLarge)
                        .shadow(color: Color.black.opacity(0.8), radius: 8, x: 2, y: 2)
                    
                    Text("your self care hub for empowerment")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .dynamicTypeSize(.xLarge)
                        .offset(x: 0.0, y: -20.0)
                        .foregroundColor(Color.white)

                    NavigationLink(destination: AvatarView()) { // 
                        Text("click here")
                            .foregroundColor(Color.white)
                    }.padding()
                }
            }
        }
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}


