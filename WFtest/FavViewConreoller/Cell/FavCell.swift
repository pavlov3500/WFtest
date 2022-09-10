import UIKit
import Kingfisher

class FavCell: UITableViewCell {

    // MARK: - TableView cell
    
    private let favCell = FavCellUIView()
    
    func configure(fav:InfoData) {
        contentView.backgroundColor = .systemGray5
        favCell.frame = self.contentView.bounds
        self.contentView.addSubview(favCell)
        
        favCell.favLabel.font = .boldSystemFont(ofSize: 17)
        
        guard let url = URL(string: fav.urls?.thumb ?? "") else {return}
        let resource = ImageResource(downloadURL: url, cacheKey: fav.urls?.thumb)
        favCell.favImageView.kf.setImage(with: resource)
        
        if let text = fav.user?.username {
            favCell.favLabel.text = text
        }
    }

}
