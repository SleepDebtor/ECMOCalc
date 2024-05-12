//
//  RespCalcView.swift
//  ECMO
//
//  Created by Michael Lazar on 5/3/24.
//

import SwiftUI
import SwiftData

struct RespCalcView: View {
	@Bindable var patient: RespScore
	
	init (item: RespScore) {
		self.patient = item
	}
	
	var body: some View {
        VStack {
            HStack {
                Text("Resp Score \(patient.score.score)")
                Spacer()
                Text("Risk Class \(patient.score.riskClass)")
                Spacer()
                Text("Survival \(patient.score.survivalPercent)")
            }
            .padding(.horizontal)
            Text("")
            Divider()
            List {
                Section("Shock Dx Group") {
                    Picker("Shock Dx Group", selection: $patient.dxGroup) {
                        ForEach(RespScore.DxGroup.allCases) { choice in
                            Text(choice.displayName)
                                .tag(choice)
                        }
                    }
                }
                .multilineTextAlignment(.leading)
                //			.toggleStyle(.button)
                Section("Age Range") {
                    Picker("Age Range", selection: $patient.ageRange) {
                        ForEach(RespScore.AgeRange.allCases) { choice in
                            Text(choice.displayName)
                                .tag(choice)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .pickerStyle(.segmented)
                Section("PA CO2") {
                    Picker("PA CO2", selection: $patient.paCO2) {
                        ForEach(RespScore.PaCO2.allCases) { choice in
                            Text(choice.displayName)
                                .tag(choice)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Peak Inspiratory Failure") {
                    Picker("Peak Inspiratory Failure", selection: $patient.peakInspPressure) {
                        ForEach(RespScore.PeakInsPressure.allCases) { choice in
                            Text(choice.displayName)
                                .tag(choice)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Intubation Duration") {
                    Picker("Intubation Duration", selection: $patient.intubationDuration) {
                        ForEach(RespScore.IntubationDuaration.allCases) { choice in
                            Text(choice.displayName)
                                .tag(choice)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Pre ECMO Organ Failure") {
                    SelectionRow(for: $patient.cns)
                    SelectionRow(for: $patient.acuteNonPulmInfection)
                    SelectionRow(for: $patient.neuroMuscularBlockade)
                    SelectionRow(for: $patient.nitricOxide)
                    SelectionRow(for: $patient.bicarbonateInfusion)
                    SelectionRow(for: $patient.cardiacArrest)
                }
            }
        }
	}
}
