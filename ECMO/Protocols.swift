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
	var scoreDisplay: String { get }
	var timestamp: Date { get }
}

typealias TheScore = AnyScore & Identifiable & Hashable

extension RespScore: TheScore {
	static func == (lhs: RespScore, rhs: RespScore) -> Bool {
		lhs.timestamp > rhs.timestamp
	}
}
extension SaveScore: TheScore { 
	static func == (lhs: SaveScore, rhs: SaveScore) -> Bool {
		lhs.timestamp > rhs.timestamp
	}
}

