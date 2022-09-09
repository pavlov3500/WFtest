import UIKit

// MARK: - Constraints

extension InfoViewController {
    func addHeaderConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(infoProfileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(infoProfileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        let width = infoProfileImageView.widthAnchor.constraint(equalToConstant: 40)
        constraints.append(width)
        constraints.append(infoProfileImageView.heightAnchor.constraint(equalTo: infoProfileImageView.widthAnchor, multiplier: 1))
        constraints.append(infoName.centerYAnchor.constraint(equalTo: infoProfileImageView.centerYAnchor))
        constraints.append(infoName.leadingAnchor.constraint(equalTo: infoProfileImageView.trailingAnchor, constant: 10))
        constraints.append(infoDownloads.centerYAnchor.constraint(equalTo: infoProfileImageView.centerYAnchor))
        constraints.append(infoDownloads.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10))
        NSLayoutConstraint.activate(constraints)
        infoProfileImageView.layer.cornerRadius = width.constant / 2
    }
    
    func addImageViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(infoImageView.topAnchor.constraint(equalTo: infoProfileImageView.bottomAnchor, constant: 10))
        constraints.append(infoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(infoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
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
