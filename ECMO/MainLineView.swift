//
//  MainLineView.swift
//  ECMO
//
//  Created by Michael Lazar on 5/15/24.
//

import SwiftUI

struct MainLineView: View {
    var body: some View {
		GeometryReader {proxy in
			HStack {
				Image(ImageResource.femaleIcon)
					.resizable()
					.scaledToFit()
				VStack(alignment: .leading) {
					Text("Save")
					Text("Resp")
					Text("Encourage")
				}
				.padding(.horizontal)
				.frame(width: proxy.size.width * 0.45)
				Button{
					//
				} label: {
					Image(systemName: "heart")
						.foregroundStyle(.red)
				}
				Button {
					//
				} label: {
					Image(systemName: "lungs")
				}
				Button("Enc") {
					//
				}
				.foregroundStyle(.red)
				Button {
					//
				} label: {
					Image(systemName: "printer")
				}
				.foregroundStyle(.gray)
			}
			.padding()
		}
    }
}

#Preview {
    MainLineView()
}
