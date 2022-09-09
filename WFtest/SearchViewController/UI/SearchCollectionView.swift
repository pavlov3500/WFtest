import UIKit
protocol SearchCollectionViewDelegate:AnyObject {
    func willBeginDragging()
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
