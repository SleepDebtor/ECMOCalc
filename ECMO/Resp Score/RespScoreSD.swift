//
//  RespScoreSD.swift
//  ECMO
//
//  Created by Michael Lazar on 5/2/24.
//

/*
 The RESP Score
 The RESP Score has been developed by ELSO and The Department of Intensive Care at The Alfred Hospital, Melbourne. It is designed to assist prediction of survival for adult patients undergoing Extra-Corporeal Membrane Oxygenation for respiratory failure. It should not be considered for patients who are not on ECMO or as substitute for clinical assessment.

 For more information see:
 Schmidt M, Bailey M, Sheldrake J, et al. Predicting Survival after ECMO for Severe Acute Respiratory Failure: the Respiratory ECMO Survival Prediction (RESP)-Score. Am J Respir Crit Care Med. 2014.
 */

import Foundation
import SwiftData

@Model
final class RespScore {
	let id = UUID()
	var scoreDisplay: String {
		return "🫁 Resp Score \(score.score), Class: \(score.riskClass) Survival \(score.survivalPercent)%"
	}
	enum AgeRange: String, Codable, CaseIterable, Identifiable {
		var id: Self { self }
		case age18to49 = "18–49"
		case age50to59 = "50–59"
		case ageGreater60 = ">66"
		
		var score: Int {
			switch self {
			case .age18to49:
				return 0
			case .age50to59:
				return -2
			case .ageGreater60:
				return -3
			}
		}
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
		
		var title: String {return "Age Range"}
	}
	
	enum DxGroup: String, Codable, CaseIterable, Identifiable {
		
		var id: Self { self }
		case viralPneumonia = "Viral Pneumonia"
		case bacterialPneumonia = "Bacterial Pneumonia"
		case asthma = "Asthma"
		case traumaBurn = "Trauma and Burn"
		case aspirationPneumonia = "Aspiration Pneumonia"
		case otherAcuteRespDistress = "Other acute respiratory diagnoses"
		case otherNonandChronicResp = "Nonrespiratory and chronic respiratory diagnoses"
		
		var score: Int {
			switch self {
			case .viralPneumonia: 3
			case .bacterialPneumonia: 3
			case .asthma: 11
			case .traumaBurn: 3
			case .aspirationPneumonia: 5
			case .otherAcuteRespDistress: 1
			case .otherNonandChronicResp: 0
			}
		}
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
		var title: String {return "Acute respiratory diagnosis group (select only one"}
	}
	
	enum PaCO2: String, Codable, CaseIterable, Identifiable {
		/*
		 PaCO2, mm Hg
		  <75	0
		  ≥75	−1
		 */
		var id: Self { self }
		case lessThan75 = "<75"
		case greaterThanOrEqual75 = "≥75"
		
		var score: Int {
			switch self {
			case .lessThan75: 0
			case .greaterThanOrEqual75: -1
			}
		}
		
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
		
		var title: String {return "PaCo2, mmHg"}
	}
	
	enum PeakInsPressure: String, Codable, CaseIterable, Identifiable {
		
		var id: Self { self }
		case lessThan42 = "<42"
		case greaterThanOrEqua42 = "≥42"
		
		var score: Int {
			switch self {
			case .lessThan42: 0
			case .greaterThanOrEqua42: -1
			}
		}
		
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
		
		var title: String {return "Peak inspiratory pressure, cm H2O"}
	}

	enum IntubationDuaration: String, Codable, CaseIterable, Identifiable {
		var id: Self { self }
		case durationlessThan48Hours = "<48h"
		case duration48hto7days = "48h-7d"
		case durationGreaterThan7days = ">7d"
		
		var score: Int {
			switch self {
			case .durationlessThan48Hours:
				return 3
			case .duration48hto7days:
				return 1
			case .durationGreaterThan7days:
				return 0
			}
		}
		var displayName: String {
			return "\(self.rawValue) (\(self.score))"
		}
		var title: String {return "Mechanical ventilation prior to initiation of ECMO"}
	}
	
// Organ Failurer
	
	// Shock Dx Group
	var immunocompromised: Parameters
	var cns: Parameters
	var acuteNonPulmInfection: Parameters
	var neuroMuscularBlockade: Parameters
	var nitricOxide: Parameters
	var bicarbonateInfusion: Parameters
	var cardiacArrest: Parameters
	
	// ranges
	var dxGroup: DxGroup
	var ageRange: AgeRange
	var paCO2: PaCO2
	var peakInspPressure: PeakInsPressure
	var intubationDuration: IntubationDuaration
	
	// standard
	var timestamp: Date
//	var age: Int?
//	var weightKg: Double?
	
	var score: Score {
		var score = -6 // constant value
		/// Shock Dx Group
		score += immunocompromised.score
		/// Individual Scores
		score += cns.score
		score += acuteNonPulmInfection.score
		score += neuroMuscularBlockade.score
		score += nitricOxide.score
		score += bicarbonateInfusion.score
		score += cardiacArrest.score
		/// Ranges
		score += dxGroup.score
		score += ageRange.score
		score += paCO2.score
		score += peakInspPressure.score
		score += intubationDuration.score
		
		var returnValue = Score(score: score)
		switch score {
		case 6...:
			returnValue.riskClass = "I"
			returnValue.survivalPercent = "92"
		case 3...5:
			returnValue.riskClass = "II"
			returnValue.survivalPercent = "76"
		case -1...2:
			returnValue.riskClass = "III"
			returnValue.survivalPercent = "57"
		case -5...(-2):
			returnValue.riskClass = "IV"
			returnValue.survivalPercent = "33"
		case ...(-6):
			returnValue.riskClass = "V"
			returnValue.survivalPercent = "18"
		default:
			returnValue.riskClass = "error"
		}
		return returnValue
	}
	
	init(age: Int? = nil, weightKg: Double? = nil) {
		// Shock Dx Group
		self.immunocompromised = Parameters(
			possibleValue: -2,
			name: "Immunocompromised status",
			explanation: "")
		self.cns = Parameters(
			possibleValue: -7,
			name: "Central nervous system dysfunction",
			explanation: "")
		self.acuteNonPulmInfection = Parameters(
			possibleValue: -3,
			name: "Acute associated (nonpulmonary) infection",
			explanation: "")
		self.neuroMuscularBlockade = Parameters(
			possibleValue: 1,
			name: "Neuromuscular blockade agents before ECMO",
			explanation: "")
		self.nitricOxide = Parameters(
			possibleValue: -1,
			name: "Nitric oxide use before ECMO",
			explanation: "")
		self.bicarbonateInfusion = Parameters(
			possibleValue: -2,
			name: "Bicarbonate infusion before ECMO",
			explanation: "")
		self.cardiacArrest = Parameters(
			possibleValue: -2,
			name: "Cardiac arrest before ECMO",
			explanation: "")
		
		// Age and weight ranges
		if let age {
			switch age {
			case ...17: self.ageRange = .age18to49
			case 18...49: self.ageRange = .age18to49
			case 50...59: self.ageRange = .age50to59
			case 60...: self.ageRange = .ageGreater60
			default:
				print("Unknow age")
				self.ageRange = .ageGreater60
			}
		} else {
			self.ageRange = AgeRange.ageGreater60
		}
		
		// Ranges
		
		self.intubationDuration = IntubationDuaration.durationlessThan48Hours
		self.dxGroup = DxGroup.otherAcuteRespDistress
		self.ageRange = AgeRange.age18to49
		self.paCO2 = PaCO2.lessThan75
		self.peakInspPressure = PeakInsPressure.lessThan42
		self.timestamp = Date()
		
//		self.ageRange = AgeRange.age18_38
//		self.weightRange = WeightRange.weight65_89Kg
	}

}
