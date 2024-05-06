//
//  ScoreStruct.swift
//  ECMO
//
//  Created by Michael Lazar on 5/3/24.
//

import Foundation

struct Score: Codable {
	var score: Int = 0
	var riskClass = ""
	var survivalPercent = ""
}
