import UIKit
import SwiftUI
class MainScreenViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let cocktailListView = UIHostingController(rootView: CocktailListView()).view {
            view.addSubview(cocktailListView)
            cocktailListView.translatesAutoresizingMaskIntoConstraints = false
            cocktailListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            cocktailListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            cocktailListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            cocktailListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        }
    }
}
