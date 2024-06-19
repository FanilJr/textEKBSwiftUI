//
//  ImageView.swift
//  FromEKBCitySwiftUI
//
//  Created by Фаниль on 19.06.2024.
//

import SwiftUI
import SwiftUI

struct ImageView: View {
    var image: String
    @State private var isNavBarHidden = false
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Spacer()
            AsyncCachedImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(scale)
                    .gesture(MagnificationGesture()
                        .onChanged { value in
                            self.scale = value
                        }
                        .onEnded { _ in
                            withAnimation {
                                self.scale = 1.0
                            }
                        })
                    .frame(width: 400, height: 600)
            } placeholder: {
                ProgressView()
            }
            .padding()
            Spacer()
            Button(action: {
                withAnimation {
                    isNavBarHidden.toggle()
                }
                toggleNavigationBarVisibility(hidden: isNavBarHidden)
            }) {
                Text(isNavBarHidden ? "показать NavBar" : "скрыть NavBar")
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isNavBarHidden ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding()
        }
        .navigationBarHidden(isNavBarHidden)
    }
    
    private func toggleNavigationBarVisibility(hidden: Bool) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        if let navigationController = windowScene.windows.first?.rootViewController as? UINavigationController {
            navigationController.setNavigationBarHidden(hidden, animated: true)
        }
    }
}

#Preview {
    ImageView(image: "")
}
