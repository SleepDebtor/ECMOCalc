//
//  EncourageTabView.swift
//  ECMO
//
//  Created by Michael Lazar on 5/14/24.
//

import SwiftUI

struct EncourageTabView: View {
		@Bindable var encourageScore: EncourageScore
		
		var body: some View {
			TabView {
				EncourageCalcView(item: encourageScore)
				Text("Info")
			}
			.tabViewStyle(.page)
		}
	}
