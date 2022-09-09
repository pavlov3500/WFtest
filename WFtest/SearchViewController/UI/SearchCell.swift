import UIKit
import Kingfisher

// MARK: - CollectionView cell

class SearchCell: UICollectionViewCell {
    
    // MARK: - add UI and layout
    
    private let searchImageView = SearchImageView(frame: CGRect.zero)
    
    private func addViews() {
        contentView.addSubview(searchImageView)
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(searchImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0))
        constraints.append(searchImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0))
        constraints.append(searchImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(searchImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(result:SearchResult) {
        self.contentView.backgroundColor = .systemGray5
        addViews()
        addConstraints()
        guard let url = URL(string: result.urls?.thumb ?? "") else {return}
        let resource = ImageResource(downloadURL: url, cacheKey: result.urls?.thumb)
        searchImageView.kf.setImage(with: resource)
    }
}
