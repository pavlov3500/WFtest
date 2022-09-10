import UIKit
import Kingfisher

// MARK: - CollectionView cell

class SearchCell: UICollectionViewCell {
        
    var cellView = SearchCellUIView()
    
    func configure(result:SearchResult) {
        self.contentView.backgroundColor = .systemGray5
        cellView.frame = self.contentView.bounds
        self.contentView.addSubview(cellView)
        guard let url = URL(string: result.urls?.thumb ?? "") else {return}
        let resource = ImageResource(downloadURL: url, cacheKey: result.urls?.thumb)
        cellView.searchImageView.kf.setImage(with: resource)
    }
}
