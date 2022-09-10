import UIKit

// MARK: - UI

class SearchViewControllerUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(searchTextField)
        self.addSubview(searchCollectionView)
        addTextFieldConstraints()
        addCollectionViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        textField.returnKeyType = .search
        textField.enablesReturnKeyAutomatically = true
        textField.placeholder = "Search something"
        textField.layer.cornerRadius = 10
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        return textField
    }()
    
    var searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = true
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "SearchCell")
        return collectionView
    }()
    
    func addTextFieldConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(searchTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(searchTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(searchTextField.heightAnchor.constraint(equalToConstant: 35))
        constraints.append(searchTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func addCollectionViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(searchCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10))
        constraints.append(searchCollectionView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor))
        constraints.append(searchCollectionView.centerXAnchor.constraint(equalTo: searchTextField.centerXAnchor))
        constraints.append(searchCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 20))
        NSLayoutConstraint.activate(constraints)
    }
    
}


