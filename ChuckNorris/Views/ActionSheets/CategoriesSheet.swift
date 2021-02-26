//
// Created by Matthijs Kropholler on 26/02/2021.
//

import SwiftUI

struct CategoriesSheet: View {
    @Binding var isPresented: Bool
    private let categories = ["explicit"]


    var body: some View {
        NavigationView {
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
                    .navigationTitle("Categories")
                    .navigationBarTitleDisplayMode(.inline)
        }
    }
}