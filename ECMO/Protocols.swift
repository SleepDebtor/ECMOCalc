//
//  SomeScoreProtocol.swift
//  ECMO
//
//  Created by Michael Lazar on 5/3/24.
//

import Foundation

protocol AnyScore: Identifiable {
	var id: UUID { get }
	static var citationStr: String { get }
	static var purposeStr: String { get }
	static var scoreTitle: String { get }
	var scoreDisplay: String { get }
	var timestamp: Date { get }
}

typealias TheScore = AnyScore & Identifiable & Hashable

extension RespScore: TheScore {
	static func == (lhs: RespScore, rhs: RespScore) -> Bool {
		lhs.timestamp > rhs.timestamp
	}
	
	func scoreConsultReport() -> String {
		let consultStr = "The RESP Score has been developed by ELSO and The Department of Intensive Care at The Alfred Hospital, Melbourne. It is designed to assist prediction of survival for adult patients undergoing Extra-Corporeal Membrane Oxygenation for respiratory failure. While is is not a substitute for clinical assessment it has been welll validated. Based on the data available, the calculated RESP score is \(score.score). This score is associated with Risk Class \(score.riskClass) and an average survival of \(score.survivalPercent)%. "
		return consultStr
	}
	
	static let scoreTitle = "RESP Score"
 
	static let citationStr = "Schmidt M, Bailey M, Sheldrake J, Hodgson C, Aubron C, Rycus PT, Scheinkestel C, Cooper DJ, Brodie D, Pellegrino V, Combes A, Pilcher D. Predicting survival after extracorporeal membrane oxygenation for severe acute respiratory failure. The Respiratory Extracorporeal Membrane Oxygenation Survival Prediction (RESP) score. Am J Respir Crit Care Med. 2014 Jun 1;189(11):1374-82. doi: 10.1164/rccm.201311-2023OC. PMID: 24693864."
	
	static let purposeStr = "The RESP Score has been developed by ELSO and The Department of Intensive Care at The Alfred Hospital, Melbourne. It is designed to assist prediction of survival for adult patients undergoing Extra-Corporeal Membrane Oxygenation for respiratory failure. It should not be considered for patients who are not on ECMO or as substitute for clinical assessment."
	
	var sample: RespScore {
		let patient = RespScore()
		return patient
	}
}
extension SaveScore: TheScore { 
	static func == (lhs: SaveScore, rhs: SaveScore) -> Bool {
		lhs.timestamp > rhs.timestamp
	}
	
	func scoreConsultReport() -> String {
		let consultStr = "The SAVE Score has been developed by ELSO and The Department of Intensive Care at The Alfred Hospital, Melbourne. It is designed to assist prediction of survival for adult patients undergoing Extra-Corporeal Membrane Oxygenation for respiratory failure. While is is not a substitute for clinical assessment it has been welll validated. Based on the data available, the calculated RESP score is \(score.score). This score is associated with Risk Class \(score.riskClass) and an average survival of \(score.survivalPercent)%. "
		return consultStr
	}
	
	static let scoreTitle = "SAVE Score"
	
	static let citationStr = "Schmidt M, Burrell A, Roberts L, Bailey M, Sheldrake J, Rycus PT, Hodgson C, Scheinkestel C, Cooper DJ, Thiagarajan RR, Brodie D, Pellegrino V, Pilcher D. Predicting survival after ECMO for refractory cardiogenic shock: the survival after veno-arterial-ECMO (SAVE)-score. Eur Heart J. 2015 Sep 1;36(33):2246-56. doi: 10.1093/eurheartj/ehv194. Epub 2015 Jun 1. PMID: 26033984."
	
	static let purposeStr = "The SAVE Score has been developed by ELSO and The Department of Intensive Care at The Alfred Hospital, Melbourne. It is designed to assist prediction of survival for adult patients undergoing Extra-Corporeal Membrane Oxygenation for refractory cardiogenic shock. It should not be considered a substitute for clinical assessment."
	
	var sample: SaveScore {
		let patient = SaveScore()
		patient.congenital.selected = true
		return patient
	}
}
extension EncourageScore: TheScore {
	static func == (lhs: EncourageScore, rhs: EncourageScore) -> Bool {
		lhs.timestamp > rhs.timestamp
	}
	
	func scoreConsultReport() -> String {
		let consultStr = "The SAVE Score has been developed by ELSO and The Department of Intensive Care at The Alfred Hospital, Melbourne. It is designed to assist prediction of survival for adult patients undergoing Extra-Corporeal Membrane Oxygenation for respiratory failure. While is is not a substitute for clinical assessment it has been welll validated. Based on the data available, the calculated RESP score is \(score.score). This score is associated with Risk Class \(score.riskClass) and an average survival of \(score.survivalPercent)%. "
		return consultStr
	}
	
	static let scoreTitle = "Encourage Score"
	
	static let citationStr = "Muller G, Flecher E, Lebreton G, Luyt CE, Trouillet JL, Bréchot N, Schmidt M, Mastroianni C, Chastre J, Leprince P, Anselmi A, Combes A. The ENCOURAGE mortality risk score and analysis of long-term outcomes after VA-ECMO for acute myocardial infarction with cardiogenic shock. Intensive Care Med. 2016 Mar;42(3):370-378. doi: 10.1007/s00134-016-4223-9. Epub 2016 Jan 29. PMID: 26825953."
	
	static let purposeStr = "This study was designed to identify factors associated with in-intensive care unit (ICU) death and develop a practical mortality risk score for venoarterial-extracorporeal membrane oxygenation (VA-ECMO)-treated acute myocardial infarction (AMI) patients. Long-term survivors' health-related quality of life (HRQOL), anxiety, depression, and post-traumatic stress disorder (PTSD) frequencies were also assessed."
	
	var sample: EncourageScore {
		let patient = EncourageScore()
		return patient
	}
}
