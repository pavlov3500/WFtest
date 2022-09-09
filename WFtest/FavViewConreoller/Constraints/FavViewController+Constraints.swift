import UIKit

extension FavViewController {
    func addTableViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(favTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(favTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(favTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(favTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20))
        NSLayoutConstraint.activate(constraints)
    }
}
