//
//  RespInfoView.swift
//  ECMO
//
//  Created by Michael Lazar on 5/5/24.
//

import SwiftUI

struct RespInfoView: View {
	var score: Score
	
	func placeLine(width: Double) -> Double {
		let start = 31.0
		let quantityTicks = width/21
		var limitedScore = score.score
		if limitedScore < -8 {
			limitedScore = -9
		} else if limitedScore >= 8 {
			limitedScore = 8
		}
		let movement = Double(limitedScore) * quantityTicks
		return start + movement
	}
	
	init(score: Score? = nil) {
		if let score {
			self.score = score
		} else {
			self.score = Score(score: 7,
							   riskClass: "II",
							   survivalPercent: "50")
		}
	}
	
	var body: some View {
		VStack {
			Spacer()
			HStack {
				Text("Save Score \(score.score)")
				Spacer()
				Text("Risk Class \(score.riskClass)")
				Spacer()
				Text("Survival \(score.survivalPercent)%")
			}
			.padding(.vertical)
			GeometryReader { proxy in
				ZStack {
					Color.gray
						.opacity(0.2)
					Rectangle()
						.fill(.red)
						.frame(minWidth: 5, idealWidth: 10, maxWidth: 10, minHeight: 50, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 270, alignment: .leading)
						.offset(x: placeLine(width: proxy.size.width))
					Image(ImageResource.respLines)
						.resizable()
						.scaledToFit()
				}
			}
			.frame(minWidth: 0, maxWidth: 400, minHeight: 0, maxHeight: 300)
			.padding(.bottom)
			Link(destination: /*@START_MENU_TOKEN@*/URL(string: "https://www.apple.com")!/*@END_MENU_TOKEN@*/) {
				Text(RespScore.citationStr)
					.font(.caption)
					.italic()
					.foregroundStyle(.blue)
			}
			Spacer()
			Text(RespScore.purposeStr)
				.font(.caption)
				.navigationTitle(SaveScore.scoreTitle)
		}
		.padding()
	}
}

#Preview {
    RespInfoView()
}
