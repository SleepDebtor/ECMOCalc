//
//  ContentView.swift
//  ECMO
//
//  Created by Michael Lazar on 4/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var vaReview: [SaveScore]
	@Query private var vvReview: [RespScore]
	@State private var navPath = NavigationPath()
	
	var allScores: [any TheScore] {
		let returnArray: [any TheScore] = vaReview + vvReview
		return returnArray.sorted {
			$0.timestamp > $1.timestamp
		}
	}

    var body: some View {
		NavigationStack(path: $navPath) {
            List {
				ForEach(allScores, id: \.id) { item in
					NavigationLink(value: item) {
						Text("\(item.scoreDisplay)")
                    }
                }
                .onDelete(perform: deleteItems)
            }
			.navigationDestination(for: SaveScore.self) { i in
				SaveTabView(saveScore: i)
			}
			.navigationDestination(for: RespScore.self) { i in
				RespTabView(respScore: i)
			}
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addAV) {
                        Label("Add VA", systemImage: "heart")
                    }
                }
				ToolbarItem {
					Button(action: addVV) {
						Label("Add VV", systemImage: "lungs")
					}
				}
            }
        }
    }

    private func addAV() {
        withAnimation {
            let newItem = SaveScore()
            modelContext.insert(newItem)
			navPath.append(newItem)
        }
    }
	
	private func addVV() {
		withAnimation {
			let newItem = RespScore()
			modelContext.insert(newItem)
			navPath.append(newItem)
		}
	}

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(vaReview[index])
            }
        }
    }
}

// #Preview {
//    ContentView()
// }
