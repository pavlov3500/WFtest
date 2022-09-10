import UIKit

// MARK: - UI

class FavViewControllerUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(favTableView)
        addTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let favTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = true
        tableView.alwaysBounceVertical = false
        tableView.register(FavCell.self, forCellReuseIdentifier: "FavCell")
        return tableView
    }()
    
    func addTableViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        constraints.append(favTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10))
        constraints.append(favTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(favTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        constraints.append(favTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 20))
        NSLayoutConstraint.activate(constraints)
    }
    
}
