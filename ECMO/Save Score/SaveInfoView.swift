//
//  SaveInfoView.swift
//  ECMO
//
//  Created by Michael Lazar on 5/5/24.
//

import SwiftUI

struct SaveInfoView: View {
    var body: some View {
		
		Image(ImageResource.saveLines)
			.resizable()
			.scaledToFit()
		Text(RespScore.citationStr)
			.font(.caption)
    }
}

#Preview {
    SaveInfoView()
}
