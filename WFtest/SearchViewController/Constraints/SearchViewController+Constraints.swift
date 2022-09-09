import UIKit

// MARK: - Constraints

extension SearchViewController {
    func addTextFieldConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(searchTextField.heightAnchor.constraint(equalToConstant: 35))
        constraints.append(searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        NSLayoutConstraint.activate(constraints)
    }
    
    func addCollectionViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(searchCollectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10))
        constraints.append(searchCollectionView.leadingAnchor.constraint(equalTo: searchTextField.leadingAnchor))
        constraints.append(searchCollectionView.centerXAnchor.constraint(equalTo: searchTextField.centerXAnchor))
        constraints.append(searchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20))
        NSLayoutConstraint.activate(constraints)
    }
}
