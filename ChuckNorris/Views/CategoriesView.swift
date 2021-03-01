//
// Created by Matthijs Kropholler on 26/02/2021.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject private var jokesViewModel: JokesViewModel

    var body: some View {
            Group {
                if (jokesViewModel.categories.isEmpty) {
                    ProgressView()
                } else {
                    List(jokesViewModel.categories, id: \.self) { category in
                        Button(action: { jokesViewModel.toggleExcludedCategory(category: category) }) {
                            HStack {
                                Text(category)

                                Spacer()

                                if jokesViewModel.categoryIsExcluded(category: category) {
                                    Image(systemName: "xmark").foregroundColor(.red)
                                }
                            }
                        }
                    }.navigationBarTitle("Excluded Categories")
                }
            }
    }
}