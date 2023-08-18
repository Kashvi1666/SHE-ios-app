//  GameView.swift
//  Created by Kashvi Swami on 8/16/23.

import Foundation
import SwiftUI

struct GameView: View {
    var body: some View {
        NavigationStack {
            Image("background").ignoresSafeArea()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
