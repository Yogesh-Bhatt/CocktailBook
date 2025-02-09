//
//  ImageLoader.swift
//  CocktailBook
//
//  Created by Yogesh Bhatt on 09/02/25.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    @State private var image: UIImage? = nil

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ActivityIndicator() 
                    .frame(width: 30, height: 30)
                    .onAppear {
                        loadImage()
                    }
            }
        }
        .frame(width: 50, height: 50)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func loadImage() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }.resume()
    }
}
