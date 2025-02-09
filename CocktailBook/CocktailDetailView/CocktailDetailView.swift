import SwiftUI

struct CocktailDetailView: View {
    let cocktail: Cocktail
    @ObservedObject var viewModel: CocktailViewModel  // Pass the existing ViewModel
    @State private var cocktailImage: UIImage? = nil
    var body: some View {
        VStack {
            // Custom Image Loader instead of AsyncImage
            if let image = cocktailImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
            } else {
                ActivityIndicator()
                    .frame(width: 50, height: 50)
                    .onAppear {
                        loadImage(from: cocktail.imageURL)
                    }
            }
            
            Text(cocktail.name).font(.largeTitle).bold()
            Text(cocktail.category).font(.headline).foregroundColor(.gray)
            Text("Instructions")
                .font(.system(size: 20, weight: .bold))
                .padding(.top)
            
            Text(cocktail.instructions).padding()
            
            Button(action: {
                viewModel.toggleFavorite(cocktail: cocktail)
            }) {
                HStack {
                    Image(systemName: viewModel.favorites.contains(cocktail.id) ? "heart.fill" : "heart")
                        .foregroundColor(.white)
                    Text(viewModel.favorites.contains(cocktail.id) ? "Remove from Favorites" : "Add to Favorites")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Cocktail Detail", displayMode: .inline)
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.cocktailImage = image
                }
            }
        }.resume()
    }
}
