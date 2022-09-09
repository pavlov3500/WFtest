import UIKit
import Kingfisher

class InfoViewController: UIViewController {
        
    // MARK: - add UI and layout
    
    let infoProfileImageView = InfoImageView(frame: CGRect.zero)
    let infoName = InfoLabel()
    let infoDownloads = InfoLabel()
    let infoImageView = InfoImageView(frame: CGRect.zero)
    let infoButton = InfoButton()
    let infoLocation = InfoLabel()
    let infoDate = InfoLabel()
    
    private func addViews() {
        view.addSubview(infoProfileImageView)
        view.addSubview(infoName)
        view.addSubview(infoDownloads)
        view.addSubview(infoImageView)
        view.addSubview(infoButton)
        view.addSubview(infoLocation)
        view.addSubview(infoDate)
    }
    
    private func addConstraints() {
        addHeaderConstraints()
        addImageViewConstraints()
        addLabelConstraints()
    }
        
    // MARK: - add properties
    
    var infoData = InfoData() {
        didSet {
            configure(data: infoData)
        }
    }
    
    private let selected = UIImage(named: "heart")
    private let normal = UIImage(named: "heart")?
                                    .colorized(with: .white)
                                    .stroked(with: .black, thickness: 15, quality: 1)
    private var isLiked = false {
        didSet {
            infoButton.setImage(isLiked ? selected : normal , for: .normal)
            self.infoButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveLinear) {
                self.infoButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
    }
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        infoImageView.backgroundColor = .lightGray
        addViews()
        addConstraints()
        isLiked = DataManager.favList.contains(where: {$0.id == infoData.id}) ? true : false
        infoButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    // MARK: - Add methods

    func configure(data:InfoData) {
        if let url = URL(string: data.user?.profile_image?.medium ?? "") {
            let profileResource = ImageResource(downloadURL: url, cacheKey: data.user?.profile_image?.medium)
            DispatchQueue.main.async {
                self.infoProfileImageView.kf.setImage(with: profileResource)
            }
        }
        
        guard let url = URL(string: data.urls?.regular ?? "") else {return}
        let resource = ImageResource(downloadURL: url)
        let options: KingfisherOptionsInfo = [.memoryCacheExpiration(.expired), .diskCacheExpiration(.expired)]
        infoImageView.kf.indicatorType = .activity
        DispatchQueue.main.async {
            self.infoImageView.kf.setImage(with: resource, placeholder: .none, options: options)
        }
        if let text = data.user?.username {
            infoName.font = .boldSystemFont(ofSize: 17)
            infoName.text = text
        }
        if let text = data.user?.location {
            infoLocation.text = text
        }
        if let text = data.created_at {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            let date = formatter.date(from: text)
            formatter.dateFormat = "dd MMMM yyyy"
            let time = formatter.string(from: date ?? Date())
            infoDate.text = time
        }
        if let text = data.downloads {
            infoDownloads.text = "\(text) downloads"
        }
    }
    
    func reloadFavList() {
        if isLiked {
            !DataManager.favList.contains(where: {$0.id == infoData.id})
                ? DataManager.favList.append(infoData)
                : nil
        } else {
            DataManager.favList.contains(where: {$0.id == infoData.id})
                ? DataManager.favList.removeAll(where: {$0.id == infoData.id})
                : nil
        }
        print(DataManager.favList.count)
    }
    
    // MARK: - Add actions
    
    @objc func buttonPressed() {
        isLiked.toggle()
        DataManager.setFavList() {
            self.reloadFavList()
        }
    }
    
}
