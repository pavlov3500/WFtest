import UIKit

// MARK: - UI

class InfoViewControllerUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(infoProfileImageView)
        self.addSubview(infoName)
        self.addSubview(infoDownloads)
        self.addSubview(infoImageView)
        self.addSubview(infoButton)
        self.addSubview(infoLocation)
        self.addSubview(infoDate)
        
        addHeaderConstraints()
        addImageViewConstraints()
        addLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let infoProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let infoName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoDownloads: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let infoLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    func addHeaderConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(infoProfileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(infoProfileImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        let width = infoProfileImageView.widthAnchor.constraint(equalToConstant: 40)
        constraints.append(width)
        constraints.append(infoProfileImageView.heightAnchor.constraint(equalTo: infoProfileImageView.widthAnchor, multiplier: 1))
        constraints.append(infoName.centerYAnchor.constraint(equalTo: infoProfileImageView.centerYAnchor))
        constraints.append(infoName.leadingAnchor.constraint(equalTo: infoProfileImageView.trailingAnchor, constant: 10))
        constraints.append(infoDownloads.centerYAnchor.constraint(equalTo: infoProfileImageView.centerYAnchor))
        constraints.append(infoDownloads.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        NSLayoutConstraint.activate(constraints)
        infoProfileImageView.layer.cornerRadius = width.constant / 2
    }
    
    func addImageViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(infoImageView.topAnchor.constraint(equalTo: infoProfileImageView.bottomAnchor, constant: 10))
        constraints.append(infoImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(infoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(infoImageView.heightAnchor.constraint(equalTo: infoImageView.widthAnchor, multiplier: 1))
        NSLayoutConstraint.activate(constraints)
    }
    
    func addLabelConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(infoButton.centerXAnchor.constraint(equalTo: infoProfileImageView.centerXAnchor))
        constraints.append(infoButton.topAnchor.constraint(equalTo: infoImageView.bottomAnchor, constant: 20))
        constraints.append(infoButton.widthAnchor.constraint(equalTo: infoProfileImageView.widthAnchor, multiplier: 0.8))
        constraints.append(infoButton.heightAnchor.constraint(equalTo: infoButton.widthAnchor))
        constraints.append(infoDate.topAnchor.constraint(equalTo: infoButton.topAnchor))
        constraints.append(infoDate.trailingAnchor.constraint(equalTo: infoImageView.trailingAnchor))
        constraints.append(infoLocation.topAnchor.constraint(equalTo: infoDate.bottomAnchor, constant: 10))
        constraints.append(infoLocation.trailingAnchor.constraint(equalTo: infoDate.trailingAnchor))
        NSLayoutConstraint.activate(constraints)
    }
}
