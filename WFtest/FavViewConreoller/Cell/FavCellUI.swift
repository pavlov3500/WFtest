import UIKit

// MARK: - Cell UI

class FavCellUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(favImageView)
        self.addSubview(favLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let favImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let favLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(favImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10))
        constraints.append(favImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))
        constraints.append(favImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10))
        constraints.append(favImageView.widthAnchor.constraint(equalTo: favImageView.heightAnchor, multiplier: 1))
        
        constraints.append(favLabel.topAnchor.constraint(equalTo: favImageView.topAnchor))
        constraints.append(favLabel.leadingAnchor.constraint(equalTo: favImageView.trailingAnchor, constant: 20))
        NSLayoutConstraint.activate(constraints)
    }
    
}
