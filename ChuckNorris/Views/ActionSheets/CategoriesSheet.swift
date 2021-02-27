//
// Created by Matthijs Kropholler on 26/02/2021.
//

import SwiftUI

struct CategoriesSheet: View {
    @Binding var isPresented: Bool
    let categories: [String]


    var body: some View {
        NavigationView {
            Group {
                if (categories.isEmpty) {
                    ProgressView()
                } else {
                    List(categories, id: \.self) { category in
                        Button(action: { print("category") }) {
                            HStack {
                                Text(category)

//                        Spacer()

//                        if selected(sorter) {
//                            Image(systemName: "checkmark")
//                        }
                            }
                        }
                    }
                }
            }.navigationTitle("Categories")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}