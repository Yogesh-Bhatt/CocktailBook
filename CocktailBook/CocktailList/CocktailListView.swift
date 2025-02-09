import SwiftUI

struct CocktailListView: View {
    @ObservedObject private var viewModel = CocktailViewModel()
    @State private var searchQuery = "Margarita"
    
    // Define filter options
    enum CocktailFilter: String, CaseIterable {
        case all = "All"
        case alcoholic = "Alcoholic"
        case nonAlcoholic = "Non-Alcoholic"
    }
    
    @State private var selectedFilter: CocktailFilter = .all // Selected filter state
    
    // Filtered cocktails based on selection
    private var filteredCocktails: [Cocktail] {
        switch selectedFilter {
        case .all:
            print(viewModel.cocktails)
            return viewModel.cocktails
        case .alcoholic:
            return viewModel.cocktails.filter { $0.category == "Cocktail" }
        case .nonAlcoholic:
            return viewModel.cocktails.filter { $0.category == "Ordinary Drink" }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                // Picker in the List Header (Only in CocktailListView)
                Section {
                    Picker("Filter", selection: $selectedFilter) {
                        ForEach(CocktailFilter.allCases, id: \.self) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical, 8)
                }
                
                // Cocktail List
                ForEach(filteredCocktails, id: \.id) { cocktail in
                    NavigationLink(destination: CocktailDetailView(cocktail: cocktail, viewModel: viewModel)) {
                        VStack(alignment: .leading) {
                            Text(cocktail.name).font(.headline)
                            Text(cocktail.instructions).font(.subheadline).foregroundColor(.gray)
                                .lineLimit(2)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .onAppear {
                print("CocktailListView appeared")
                viewModel.fetchCocktails(query: searchQuery)
            }
        }.navigationViewStyle(StackNavigationViewStyle()) 
    }
}
