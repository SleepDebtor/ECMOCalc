//
//  Item.swift
//  ECMO
//
//  Created by Michael Lazar on 4/24/24.
//
/*
 The SAVE Score has been developed by ELSO and The Department of Intensive Care at The Alfred Hospital, Melbourne. It is designed to assist prediction of survival for adult patients undergoing Extra-Corporeal Membrane Oxygenation for refractory cardiogenic shock. It should not be considered a substitute for clinical assessment.

 For more information see: Predicting survival after ECMO for refractory cardiogenic shock: the survival after veno-arterial-ECMO (SAVE)-score
 */

import Foundation
import SwiftData

@Model
final class SaveScore {
	let id = UUID()
	
	enum AgeRange: String, Codable, CaseIterable, Identifiable {
		var id: Self { self }
		case age18to38 = "18–38"
		case age39to52 = "39–52"
		case age53to62 = "53–62"
		case ageGreater63 = ">63"
		
		var score: Int {
			switch self {
			case .age18to38:
				return 7
			case .age39to52:
				return 4
			case .age53to62:
				return 3
			case .ageGreater63:
				return 0
			}
		}
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
	}
	
	enum WeightRange: String, Codable, CaseIterable, Identifiable {
		var id: Self { self }
		case weightLessThan65kg = "<65"
		case weight65to89Kg = "65-89"
		case weightGreaterThan89Kg = ">89Kg"
		
		var score: Int {
			switch self {
			case .weightLessThan65kg:
				return 1
			case .weight65to89Kg:
				return 2
			case .weightGreaterThan89Kg:
				return 0
			}
		}
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
	}
	
	enum IntubationDuaration: String, Codable, CaseIterable, Identifiable {
		var id: Self { self }
		case durationlessThan10Hours = "<10"
		case duration11to29Hours = "11-29"
		case durationGreaterThan30 = ">30"
		
		var score: Int {
			switch self {
			case .durationlessThan10Hours:
				return 0
			case .duration11to29Hours:
				return -2
			case .durationGreaterThan30:
				return -4
			}
		}
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
	}
	
	var scoreDisplay: String {
		return "❤️ Save Score \(score.score), Class: \(score.riskClass) Survival \(score.survivalPercent)?"
	}
//
//	func ageValue (forAgeRange age: AgeRange) -> Int {
//		switch age {
//		case .age18_38:
//			return 7
//		case .age39_52:
//			return 4
//		case .age53_62:
//			return 3
//		case .ageGreater63:
//			return 0
//		}
//	}
	
// Organ Failurer
	
	// Shock Dx Group
	var myocarditis: Parameters
	var refractoryVF: Parameters
	var postTX: Parameters
	var congenital: Parameters
	var other: Parameters
	
	// age and weight
	var ageRange: AgeRange
	var weightRange: WeightRange
	
	// organ failure
	var liverFailure: Parameters
	var cns: Parameters
	var renalFailure: Parameters
	var chronicRenalFailure: Parameters
	var intubationDuration: IntubationDuaration
	var peakInspPressureLessThan20: Parameters
	var cardiacArrest: Parameters
	var diastolicPressureGreater40mmHg: Parameters
	var pulsePressureLessThan20: Parameters
	var bicarbLessThan15: Parameters
	
	// standard
	var timestamp: Date
//	var age: Int?
//	var weightKg: Double?
	
	var score: Score {
		var score = -6 // constant value
		/// Shock Dx Group
		score += myocarditis.score
		score += refractoryVF.score
		score += postTX.score
		score += congenital.score
		score += other.score
		/// Weight and age
		score += weightRange.score
		score += ageRange.score
		/// Organ Failure
		score += liverFailure.score
		score += cns.score
		score += renalFailure.score
		score += chronicRenalFailure.score
		/// Vent
		score += intubationDuration.score
		score += peakInspPressureLessThan20.score
		
		score += cardiacArrest.score
		score += diastolicPressureGreater40mmHg.score
		score += pulsePressureLessThan20.score
		score += bicarbLessThan15.score
		
		var returnValue = Score(score: score)
		switch score {
		case 5...:
			returnValue.riskClass = "I"
			returnValue.survivalPercent = "75"
		case 1...5:
			returnValue.riskClass = "II"
			returnValue.survivalPercent = "58"
		case -4...0:
			returnValue.riskClass = "III"
			returnValue.survivalPercent = "42"
		case -9...(-5):
			returnValue.riskClass = "IV"
			returnValue.survivalPercent = "30"
		case ...(-10):
			returnValue.riskClass = "V"
			returnValue.survivalPercent = "18"
		default:
			returnValue.riskClass = "error"
		}
		return returnValue
	}
	
	init(age: Int? = nil, weightKg: Double? = nil) {
		
		// Shock Dx Group
		self.myocarditis = Parameters(
			possibleValue: 3,
			name: "Myocarditis",
			explanation: "")
		self.refractoryVF = Parameters(
			possibleValue: 2,
			name: "Refratory VT or VF",
			explanation: "")
		self.postTX = Parameters(
			possibleValue: 3,
			name: "Post heart or lung transplantation",
			explanation: "")
		self.congenital = Parameters(
			possibleValue: -3,
			name: "Congenital heart disease",
			explanation: "")
		self.other = Parameters(
			possibleValue: 0,
			name: "Other diagnoses leading to cardiogenic shock requiring VA ECMO",
			explanation: "")
		
		// Age and weight ranges
		if let age {
			switch age {
			case ...17: self.ageRange = .age18to38
			case 18...38: self.ageRange = .age18to38
			case 39...52: self.ageRange = .age39to52
			case 53...62: self.ageRange = .age53to62
			case 63...: self.ageRange = .ageGreater63
			default:
				print("Unknow age")
				self.ageRange = .ageGreater63
			}
		} else {
			self.ageRange = AgeRange.age18to38
		}
		
		if let weightKg {
			switch weightKg {
			case ...65: self.weightRange = .weightLessThan65kg
			case 65...89: self.weightRange = .weight65to89Kg
			case 89...: self.weightRange = .weightGreaterThan89Kg
			default:
				print("Unknow aweight")
				self.weightRange = .weight65to89Kg
			}
		} else {
			self.weightRange = WeightRange.weight65to89Kg
		}
		
		// Organ failure
		self.liverFailure = Parameters(possibleValue: -3, name: "Liver Failure")
		self.cns = Parameters(possibleValue: -3, name: "Central Nervous System Dysfunction")
		self.renalFailure = Parameters(possibleValue: -3, name: "Acute Renal Failure")
		self.chronicRenalFailure = Parameters(possibleValue: -6, name: "Chronic Renal Failure")
		
		// Presentation
		self.intubationDuration = IntubationDuaration.durationlessThan10Hours
		self.peakInspPressureLessThan20 = Parameters(possibleValue: 3, name: "Peak inspiratory pressure ≤20cm H20")
		self.cardiacArrest = Parameters(possibleValue: -2, name: "Pre-ECMO cardiac arrest")
		self.diastolicPressureGreater40mmHg = Parameters(possibleValue: 3, name: "Diastolic blood pressure before ECMO ≥ 40 mm Hg")
		self.pulsePressureLessThan20 = Parameters(possibleValue: -2, name: "Pulse pressure before ECMO ≤20 mm Hg")
		self.bicarbLessThan15 = Parameters(possibleValue: -3, name: "HCO 3 before ECMO ≤15 mmol/L")
		
		self.timestamp = Date()
	}
}
