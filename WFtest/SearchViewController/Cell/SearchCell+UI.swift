import UIKit

// MARK: - Cell UI

class SearchCellUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(searchImageView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(searchImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0))
        constraints.append(searchImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0))
        constraints.append(searchImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(searchImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        NSLayoutConstraint.activate(constraints)
    }
}
