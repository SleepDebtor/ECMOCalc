//
//  SelectionRow.swift
//  ECMO
//
//  Created by Michael Lazar on 4/25/24.
//

import SwiftUI
import SwiftData

struct SelectionRow: View {
	@State var someField: Parameters
	
	init (for someField: Parameters) {
		self.someField = someField
	}
	
    var body: some View {
		HStack {
			Toggle(someField.displayName, isOn: $someField.selected)
			Spacer()
			Text(someField.displayScore)
		}
    }
}

#Preview {
	SelectionRow(for: Parameters.example)
		.modelContainer(for: SaveScore.self, inMemory: true)
}
