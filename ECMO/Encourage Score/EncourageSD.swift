//
//  EncourageSD.swift
//  ECMO
//
//  Created by Michael Lazar on 5/14/24.
//
// 
import Foundation
import SwiftData

@Model
final class EncourageScore {
	let id = UUID()
	var scoreDisplay: String {
		return "❤️ Encourage Score \(score.score), Class: \(score.riskClass) Survival \(score.survivalPercent)%"
	}
	enum Lactate: String, Codable, CaseIterable, Identifiable {
		var id: Self { self }
		case lessThan2 = "<2 mmol/L"
		case from2To8 = "2-8 mmol/L"
		case greaterThan8 = ">8 mmol/L"
		
		var score: Int {
			switch self {
			case .lessThan2:
				0
			case .from2To8:
				8
			case .greaterThan8:
				11
			}
		}
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
		
		var title: String {return "Serum Lactate"}
	}

// Score Parameters
	
	// individual
	var ageGreater60: Parameters
	var isFemale: Parameters
	var bmiGreaterThan25: Parameters
	var gcsLess6: Parameters
	var creatGreater150: Parameters
	var ptActivityLessThan50percent: Parameters
	
	// ranges
	var lactate: Lactate
	
	// standard
	var timestamp: Date
//	var age: Int?
//	var weightKg: Double?
	
	var score: Score {
		var score = -6 // constant value
		/// Individual Scores
		score += ageGreater60.score
		score += isFemale.score
		score += bmiGreaterThan25.score
		score += gcsLess6.score
		score += creatGreater150.score
		score += ptActivityLessThan50percent.score
		/// Ranges
		score += lactate.score
		
		var returnValue = Score(score: score)
		switch score {
		case ...12:
			returnValue.riskClass = "I"
			returnValue.survivalPercent = "92"
		case 13...18:
			returnValue.riskClass = "II"
			returnValue.survivalPercent = "70"
		case 19...22:
			returnValue.riskClass = "III"
			returnValue.survivalPercent = "35"
		case 23...27:
			returnValue.riskClass = "IV"
			returnValue.survivalPercent = "28"
		case 28...:
			returnValue.riskClass = "V"
			returnValue.survivalPercent = "17"
		default:
			returnValue.riskClass = "error"
		}
		return returnValue
	}
	
	init(age: Int? = nil, weightKg: Double? = nil) {
		timestamp = Date()
		
		// Individual
		self.ageGreater60 = Parameters(
			possibleValue: 5,
			name: "Age > 60 years",
			explanation: "")
		self.isFemale = Parameters(
			possibleValue: 7,
			name: "Female",
			explanation: "")
		self.bmiGreaterThan25 = Parameters(
			possibleValue: 6,
			name: "Body mass index >25 kg/m2",
			explanation: "")
		self.gcsLess6 = Parameters(
			possibleValue: 6,
			name: "Glasgow coma score <6",
			explanation: "")
		self.creatGreater150 = Parameters(
			possibleValue: 5,
			name: "Creatinemia >150 μmol/L",
			explanation: "")
		self.ptActivityLessThan50percent = Parameters(
			possibleValue: 5,
			name: "Prothrombin activity <50 %",
			explanation: "")
		
		// Ranges
		
		self.lactate = .lessThan2
		if let age {
			if age > 60 {
				self.ageGreater60.selected = true
			}
		}
//		self.ageRange = AgeRange.age18_38
//		self.weightRange = WeightRange.weight65_89Kg
	}
}
