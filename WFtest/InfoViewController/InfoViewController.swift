import UIKit
import Kingfisher

class InfoViewController: UIViewController {
    
    var infoData = InfoData()
    
    convenience init() {
        self.init(infoData: InfoData())
    }
    
    init(infoData: InfoData?) {
        self.infoData = infoData ?? InfoData()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - add UI and layout
    
    let infoView = InfoViewControllerUIView()
    
    override func loadView() {
        self.view = infoView
    }
        
    // MARK: - add properties
        
    private let selected = UIImage(named: "heart")
    private let normal = UIImage(named: "heart")?
                                    .colorized(with: .white)
                                    .stroked(with: .black, thickness: 15, quality: 1)
    private var isLiked = false {
        didSet {
            infoView.infoButton.setImage(isLiked ? selected : normal , for: .normal)
            self.infoView.infoButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.08, delay: 0, options: .curveLinear) {
                self.infoView.infoButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
        
    }
    
    // MARK: - Controller cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        isLiked = DataManager.favList.contains(where: {$0.id == infoData.id}) ? true : false
        infoView.infoButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        configure(data: infoData)
    }
    
    // MARK: - Add methods

    func configure(data:InfoData) {
        if let url = URL(string: data.user?.profile_image?.medium ?? "") {
            let profileResource = ImageResource(downloadURL: url, cacheKey: data.user?.profile_image?.medium)
            DispatchQueue.main.async {[weak self] in
                self?.infoView.infoProfileImageView.kf.setImage(with: profileResource)
            }
        }
        
        guard let url = URL(string: data.urls?.regular ?? "") else {return}
        let resource = ImageResource(downloadURL: url)
        let options: KingfisherOptionsInfo = [.memoryCacheExpiration(.expired), .diskCacheExpiration(.expired)]
        infoView.infoImageView.kf.indicatorType = .activity
        DispatchQueue.main.async {[weak self] in
            self?.infoView.infoImageView.kf.setImage(with: resource, placeholder: .none, options: options)
        }
        if let text = data.user?.username {
            infoView.infoName.font = .boldSystemFont(ofSize: 17)
            infoView.infoName.text = text
        }
        if let text = data.user?.location {
            infoView.infoLocation.text = text
        }
        if let text = data.created_at {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            let date = formatter.date(from: text)
            formatter.dateFormat = "dd MMMM yyyy"
            let time = formatter.string(from: date ?? Date())
            infoView.infoDate.text = time
        }
        if let text = data.downloads {
            infoView.infoDownloads.text = "\(text) downloads"
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
        DataManager.setFavList() {[weak self] in
            DispatchQueue.main.async {
                self?.reloadFavList()
            }
        }
    }
    
}
