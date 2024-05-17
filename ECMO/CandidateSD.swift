//
//  CandidateSD.swift
//  ECMO
//
//  Created by Michael Lazar on 5/15/24.
//

import Foundation
import SwiftData

enum Gender: String, Codable, CaseIterable, Identifiable {
		var id: Self {self}
		case male
		case female
		case unknown
	}

@Model
final class Candidate {
	
	let id: UUID
	var initials: String
	var age: Int?
	var gender: Gender
	
	var saveScore: SaveScore?
	var respScore: RespScore?
	var encourageSCore: EncourageScore?
	
	init(initials: String = "", age: Int? = nil, gender: Gender) {
		self.id = UUID()
		self.initials = initials
		self.age = age
		self.gender = .unknown
	}
}
