//
//  EncourageCalcView.swift
//  ECMO
//
//  Created by Michael Lazar on 5/14/24.
//

import SwiftUI

struct EncourageCalcView: View {
	@Bindable var patient: EncourageScore
	
	init (item: EncourageScore) {
		self.patient = item
	}
	
	var body: some View {
		VStack {
			HStack {
				Text("Encourage Score \(patient.score.score)")
				Spacer()
				Text("Risk Class \(patient.score.riskClass)")
				Spacer()
				Text("Survival \(patient.score.survivalPercent)")
			}
			.padding(.horizontal)
			Text("")
			Divider()
			List {
				Section("\(patient.lactate.title)") {
					Picker("\(patient.lactate.title)", selection: $patient.lactate) {
						ForEach(EncourageScore.Lactate.allCases) { choice in
							Text(choice.displayName)
								.tag(choice)
						}
					}
					.pickerStyle(.segmented)
				}
				Section("Pre ECMO Organ Failure") {
					SelectionRow(for: $patient.ageGreater60)
					SelectionRow(for: $patient.isFemale)
					SelectionRow(for: $patient.bmiGreaterThan25)
					SelectionRow(for: $patient.gcsLess6)
					SelectionRow(for: $patient.creatGreater150)
					SelectionRow(for: $patient.ptActivityLessThan50percent)
				}
			}
		}
	}
}

// #Preview {
//     EncourageCalcView()
// }
