//  Created by Kashvi on 8/15/23.

import Foundation
import SwiftUI

struct GradientView: View {
    @State private var colorIndex = 0
    
    private let colors: [Color] = [
        Color(red: 78/255, green: 24/255, blue: 68/255), // purple
        Color(red: 90/255, green: 65/255, blue: 64/255), // brown
        Color(red: 120/255, green: 7/255, blue: 63/255), // red
        Color(red: 90/255, green: 65/255, blue: 64/255) // brown
    ]

    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [colors[colorIndex], colors[(colorIndex + 1) % colors.count]]), startPoint: .top, endPoint: .bottom)
            .onReceive(timer) { _ in
                withAnimation(.linear(duration: 0.4)) {
                    colorIndex = (colorIndex + 1) % colors.count
                }
            }
    }
}


