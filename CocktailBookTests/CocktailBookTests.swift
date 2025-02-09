import XCTest
@testable import CocktailBook

class CocktailViewModelTests: XCTestCase {
    
    // Mock Cocktail Service
    class MockCocktailService: CocktailServiceProtocol {
        func fetchCocktails(query: String, completion: @escaping ([Cocktail]) -> Void) {
            let mockCocktails = [
                Cocktail.init(id: "0", name: "Margarita", category: "Alcoholic", instructions: "Cocktail", imageURL: "Cocktail"),
                Cocktail.init(id: "1", name: "Virgin Mojito", category: "Non-Alcoholic", instructions: "Cocktail", imageURL: "Cocktail")
            ]
            completion(mockCocktails)
        }
    }
    
    func testFetchCocktails() {
        let mockService = MockCocktailService()
        let viewModel = CocktailViewModel(service: mockService)
        
        // Call fetch method
        viewModel.fetchCocktails(query: "Margarita")
        
        // Expectation for async operation
        let expectation = XCTestExpectation(description: "Cocktails should be loaded")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.cocktails.count, 2)
            XCTAssertEqual(viewModel.cocktails[0].name, "Margarita")
            XCTAssertEqual(viewModel.cocktails[1].name, "Virgin Mojito")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    

}
