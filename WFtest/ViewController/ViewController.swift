import UIKit
import Network

class ViewController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Set TabBarController

    private func loadTabBarController() {
        delegate = self
        self.tabBar.barStyle = .default
        let searhController = SearchViewController()
        let favController = FavViewController()
        let controllers = [searhController,favController]
        self.viewControllers = controllers
        self.selectedIndex = 1
        self.selectedIndex = 0
        let appearance = UITabBarItem.appearance()
        let attributes = [NSMutableAttributedString.Key.font:UIFont(name: "ArialMT", size: 20)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTabBarController()
        view.backgroundColor = .white
        setFavList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkConnection(action: ())
    }
    
    // MARK: - Add methods
    
    private func setFavList() {
        guard let favList = UserDefaults.standard.value([InfoData].self, forKey: "favList") else {
            UserDefaults.standard.setValue(DataManager.favList, forKey: "favList")
            return
        }
        DataManager.favList = favList
    }
        
}

