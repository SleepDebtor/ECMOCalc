//
//  SaveVar.swift
//  ECMO
//
//  Created by Michael Lazar on 4/25/24.
//

import Foundation
import SwiftData

@Model
final class Parameters {
	
	let possibleValue: Int
	var name: String = ""
	var selected: Bool = false
	var explanation: String = ""
	var score: Int {
		return selected ? possibleValue : 0
	}
	var displayName: String {
		return "\(name) (\(possibleValue)) "
	}
	var displayScore: String {
		if self.score == 0  {
			return "  "
		} else if self.score < 0 {
			return " \(score)"
		} else {
			return "  \(score)"
		}
	}
	
	static var example: Parameters {
		return Parameters(possibleValue: 7,
					   name: "Some Bad Thing",
					   explanation: "A description of the thing that wouold let it get selected"
					   )
	}
	
	init(possibleValue: Int = 0, name: String = "", selected: Bool = false, explanation: String = "") {
		self.possibleValue = possibleValue
		self.name = name
		self.selected = selected
		self.explanation = explanation
	}
}

