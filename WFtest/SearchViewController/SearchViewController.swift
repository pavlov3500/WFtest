import UIKit

class SearchViewController: UIViewController {

    // MARK: - add UI and layout
    
    let searchView = SearchViewControllerUIView()
    
    override func loadView() {
        self.view = searchView
    }
    
    // MARK: - Add properties
    
    var search = String()
    var searchResult = [SearchResult]()
    var totalPages = Int()
    var currentPage = Int() {
        didSet {
            switch Reachability().isConnectedToNetwork() {
            case true:
                getSearch(page: currentPage, search: search)
            default:
                checkConnection(action: searchView.searchCollectionView.isUserInteractionEnabled = true)
            }
            
        }
    }
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.searchTextField.delegate = self
        searchView.searchCollectionView.delegate = self
        searchView.searchCollectionView.dataSource = self
        view.backgroundColor = .clear
        self.title = "Search"
        search = "popular"
        currentPage = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchView.searchCollectionView.isUserInteractionEnabled = true
    }
    
    // MARK: - Add methods

    func getSearch(page: Int, search: String) {
        print(page,search)
        NetworkManager.shared.getSearch(per_page: 30, page: page, search: search) { [weak self](response) in
            switch response {
            case .success(let data):
                guard let results = data.results,
                      let pages = data.total_pages else {return}
                self?.searchResult.append(contentsOf: results)
                self?.totalPages = pages
                DispatchQueue.main.async {[weak self] in
                    self?.searchView.searchCollectionView.reloadData()
                }
            case .failure(let error):
                self?.getAlert(title: error.localizedDescription,
                         message: error.localizedDescription) {
                    print(0)
                }
            }
            
        }
    }
    
    func getInfo(id: String) {
        Reachability().isConnectedToNetwork()
            ? NetworkManager.shared.getInfo(id: id) { [weak self](response) in
                
                switch response {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.presentInfoController(data: data)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.getAlert(title: error.localizedDescription,
                                       message: error.localizedDescription) {
                            self?.searchView.searchCollectionView.isUserInteractionEnabled = true
                        }
                    }
                }
            }
            : checkConnection(action: searchView.searchCollectionView.isUserInteractionEnabled = true)
    }
    
    func presentInfoController(data: InfoData) {
        let controller = InfoViewController(infoData: data)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text == "" {
            searchResult.removeAll()
            searchView.searchCollectionView.contentOffset.y = 0
            search = "popular"
            currentPage = 1
        }
    }
        
}

// MARK: - SearchTextField Delegate

extension SearchViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        let text = textField.text ?? ""
        searchResult.removeAll()
        searchView.searchCollectionView.reloadData()
        search = text
        currentPage = 1
        totalPages = currentPage + 1
        return true
    }
}

// MARK: - ScrollView Delegate

extension SearchViewController:UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y
        let height = scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom
        if offset > height && totalPages > currentPage {
            currentPage += 1
            UIView.animate(withDuration: 0.3) {
                scrollView.contentOffset.y += 50
            }
        }
        
    }
}

// MARK: - CollectionView Delegate

extension SearchViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else {return UICollectionViewCell()}
        cell.configure(result: searchResult[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 21) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = searchResult[indexPath.item].id else {return}
        searchView.searchCollectionView.isUserInteractionEnabled = false
        getInfo(id: id)
    }
}
