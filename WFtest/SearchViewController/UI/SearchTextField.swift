import UIKit

class SearchTextField:UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemGray5
        returnKeyType = .search
        enablesReturnKeyAutomatically = true
        placeholder = "Search something"
        layer.cornerRadius = 10
        layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
    }
    
}
