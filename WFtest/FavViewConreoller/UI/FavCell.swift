import UIKit
import Kingfisher

class FavCell: UITableViewCell {

    // MARK: - TableView cell
    
    private let favImageView = FavImageView(frame: CGRect.zero)
    private let favLabel = FavLabel()
    
    private func addViews() {
        contentView.addSubview(favImageView)
        contentView.addSubview(favLabel)
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(favImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10))
        constraints.append(favImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10))
        constraints.append(favImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10))
        constraints.append(favImageView.widthAnchor.constraint(equalTo: favImageView.heightAnchor, multiplier: 1))
        
        constraints.append(favLabel.topAnchor.constraint(equalTo: favImageView.topAnchor))
        constraints.append(favLabel.leadingAnchor.constraint(equalTo: favImageView.trailingAnchor, constant: 20))
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(fav:InfoData) {
        contentView.backgroundColor = .systemGray5
        addViews()
        addConstraints()
        favLabel.font = .boldSystemFont(ofSize: 17)
        
        guard let url = URL(string: fav.urls?.thumb ?? "") else {return}
        let resource = ImageResource(downloadURL: url, cacheKey: fav.urls?.thumb)
        favImageView.kf.setImage(with: resource)
        
        if let text = fav.user?.username {
            favLabel.text = text
        }
    }

}
