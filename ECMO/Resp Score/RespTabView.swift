//
//  RespTabView.swift
//  ECMO
//
//  Created by Michael Lazar on 5/5/24.
//

import SwiftUI

struct RespTabView: View {
	@Bindable var respScore: RespScore
	
	var body: some View {
		TabView {
			RespCalcView(item: respScore)
			RespInfoView(score: respScore.score)
		}
		.tabViewStyle(.page)
	}
}
