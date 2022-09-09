import UIKit

class FavViewController: UIViewController {

    // MARK: - add UI and layout
    
    let favTableView = FavTableView()
    
    private func addViews() {
        favTableView.delegate = self
        favTableView.dataSource = self
        view.addSubview(favTableView)
    }
    
    private func addConstraints() {
        addTableViewConstraints()
    }
        
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        self.title = "Favorites"
        addViews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favTableView.reloadData()
    }
    
    // MARK: - Add methods

    func getInfo(id: String) {
        NetworkManager.shared.getInfo(id: id) { (data) in
            DispatchQueue.main.async {
                self.presentInfoController(data: data)
            }
        }
    }
    
    func presentInfoController(data: InfoData) {
        let controller = InfoViewController()
        controller.infoData = data
        self.navigationController?.pushViewController(controller, animated: true)
    }

}
