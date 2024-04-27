//
//  CalculatorView.swift
//  ECMO
//
//  Created by Michael Lazar on 4/24/24.
//

import SwiftUI
import SwiftData

struct CalculatorView: View {
	@State var patient: SaveScore
	
    var body: some View {
		HStack {
			Text("Save Score \(patient.saveScore.score)")
			Spacer()
			Text("Risk Class \(patient.saveScore.riskClass)")
			Spacer()
			Text("Survival \(patient.saveScore.survivalPercent)")
		}
		Text("")
		Divider ()
		List {
			Section ("Shock Dx Group") {
				SelectionRow(for: patient.myocarditis)
				SelectionRow(for: patient.refractoryVF)
				SelectionRow(for: patient.postTX)
				SelectionRow(for: patient.congenital)
				SelectionRow(for: patient.other)
			}
			.multilineTextAlignment(.leading)
//			.toggleStyle(.button)
			Section ("Age Range") {
				Picker("Age Range", selection: $patient.ageRange) {
					ForEach (SaveScore.AgeRange.allCases) { choice in
						Text(choice.displayName)
							.tag(choice)
					}
				}
			}
			.pickerStyle(.segmented)
			Section ("Weight Range") {
				Picker("Weight Range", selection: $patient.weightRange) {
					ForEach (SaveScore.WeightRange.allCases) { choice in
						Text(choice.displayName)
							.tag(choice)
					}
				}
				.pickerStyle(.segmented)
			}
			Section ("Pre ECMO Organ Failure") {
				SelectionRow(for: patient.liverFailure)
				SelectionRow(for: patient.cns)
				SelectionRow(for: patient.renalFailure)
				SelectionRow(for: patient.chronicRenalFailure)
			}
			Section ("Presenting Features") {
				Picker("Intubation Time", selection: $patient.intubationDuration) {
					ForEach (SaveScore.IntubationDuaration.allCases) { choice in
						Text(choice.displayName)
							.tag(choice)
					}
				}
				.pickerStyle(.segmented)
				SelectionRow(for: patient.peakInspPressureLessThan20)
				SelectionRow(for: patient.cardiacArrest)
				SelectionRow(for: patient.diastolicPressureGreater40mmHg)
				SelectionRow(for: patient.pulsePressureLessThan20)
				SelectionRow(for: patient.bicarbLessThan15)
			}
		}
    }
}

//#Preview {
//	CalculatorView(patient: Discernment.sample)
//}
