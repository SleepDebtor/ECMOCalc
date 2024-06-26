//
//  SaveTabView.swift
//  ECMO
//
//  Created by Michael Lazar on 5/5/24.
//

import SwiftUI

struct SaveTabView: View {
	@Bindable var saveScore: SaveScore
	
    var body: some View {
		TabView {
			CalculatorView(saveScore: saveScore)
			SaveInfoView(score: saveScore.score)
		}
		.tabViewStyle(.page)
    }
}

// #Preview {
//    SaveTabView(saveScore: SaveScore())
//		.modelContainer(for: SaveScore, inMemory: true)
// }
