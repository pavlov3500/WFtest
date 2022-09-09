import UIKit

// MARK: - UI

class SearchTextField:UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        returnKeyType = .search
        enablesReturnKeyAutomatically = true
        placeholder = "Search something"
        layer.cornerRadius = 10
        layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
    }
    
}

class SearchCollectionView:UICollectionView {
        
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = .zero
        self.init(frame: CGRect.zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsVerticalScrollIndicator = true
        register(SearchCell.self, forCellWithReuseIdentifier: "SearchCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


