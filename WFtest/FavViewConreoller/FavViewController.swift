import UIKit

class FavViewController: UIViewController {

    // MARK: - add UI and layout
    
    let favView = FavViewControllerUIView()
    
    override func loadView() {
        self.view = favView
    }
        
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favView.favTableView.delegate = self
        favView.favTableView.dataSource = self
        view.backgroundColor = .clear
        self.title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favView.favTableView.reloadData()
    }
    
    // MARK: - Add methods

    func getInfo(id: String) {
        Reachability().isConnectedToNetwork()
            ? NetworkManager.shared.getInfo(id: id) { [weak self](response) in
                
                switch response {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.presentInfoController(data: data)
                    }
                case .failure(let error):
                    self?.getAlert(title: error.localizedDescription,
                                   message: error.localizedDescription) {
                        
                    }
                }
            }
            : checkConnection(action: ())
    }
    
    func presentInfoController(data: InfoData) {
        let controller = InfoViewController(infoData: data)
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

// MARK: - TableView Delegate

extension FavViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as? FavCell else {return UITableViewCell()}
        cell.configure(fav: DataManager.favList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height / 7
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = DataManager.favList[indexPath.row].id else {return}
        getInfo(id: id)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
        DataManager.setFavList {
            DataManager.favList.remove(at: indexPath.row)
        }
        favView.favTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
}
