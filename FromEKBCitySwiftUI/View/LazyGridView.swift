//
//  ContentView.swift
//  FromEKBCitySwiftUI
//
//  Created by Фаниль on 19.06.2024.
//

import SwiftUI

struct LazyGridView: View {
    
    @State private var viewModel = ViewModel()
    
    let columns = [GridItem(.adaptive(minimum: 80))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { item in
                        NavigationLink {
                            ImageView(image: item)
                        } label: {
                            AsyncCachedImage(url: URL(string: item)) { image in image
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            } placeholder: {
                                ProgressView()
                            }

                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Загрузки")
        }
    }
}


#Preview {
    LazyGridView()
}
