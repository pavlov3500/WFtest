import UIKit

class SearchViewController: UIViewController {

    // MARK: - add UI and layout
    
    let searchTextField = SearchTextField()
    let searchCollectionView = SearchCollectionView()
    
    private func addViews() {
        searchTextField.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        view.addSubview(searchTextField)
        view.addSubview(searchCollectionView)
    }
    
    private func addConstraints() {
        addTextFieldConstraints()
        addCollectionViewConstraints()
    }
    
    // MARK: - Add properties
    
    var search = String()
    var searchResult = [SearchResult]()
    var totalPages = Int()
    var currentPage = Int() {
        didSet {
            getSearch(page: currentPage, search: search)
        }
    }
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        self.title = "Search"
        addViews()
        addConstraints()
        search = "popular"
        currentPage = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchCollectionView.isUserInteractionEnabled = true
    }
    
    // MARK: - Add methods

    func getSearch(page: Int, search: String) {
        print(page,search)
        NetworkManager.shared.getSearch(per_page: 30, page: page, search: search) { (data) in
            guard let results = data.results,
                  let pages = data.total_pages else {return}
            self.searchResult.append(contentsOf: results)
            self.totalPages = pages
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }
        }
    }
    
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
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text == "" {
            searchResult.removeAll()
            searchCollectionView.contentOffset.y = 0
            search = "popular"
            currentPage = 1
        }
    }
        
}
