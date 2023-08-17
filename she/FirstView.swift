import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("background")
                    .ignoresSafeArea()
                VStack {
                    Text("S.H.E")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .offset(x: 0.0, y: -60.0)
                        .dynamicTypeSize(.xxxLarge)
                        .shadow(color: Color.black.opacity(0.8), radius: 8, x: 2, y: 2)
                    
                    Text("your self care hub for empowerment")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .dynamicTypeSize(.xLarge)
                        .offset(x: 0.0, y: -20.0)
                        .foregroundColor(.white)

                    NavigationLink(destination: AvatarView()) {
                        Text("click here")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .padding()
                }
            }
        }.navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
