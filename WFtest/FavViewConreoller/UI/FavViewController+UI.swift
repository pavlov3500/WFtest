import UIKit

// MARK: - UI

class FavTableView:UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsVerticalScrollIndicator = true
        alwaysBounceVertical = false
        register(FavCell.self, forCellReuseIdentifier: "FavCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
