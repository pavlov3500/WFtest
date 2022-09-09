import Foundation

class DataManager {

static var favList = [InfoData]()

    static func setFavList(insideBlock: @escaping()->()) {
        DataManager.favList = UserDefaults.standard.value([InfoData].self, forKey: "favList") ?? [InfoData]()
        insideBlock()
        UserDefaults.standard.set(encodable: DataManager.favList, forKey: "favList")
    }
}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>( _ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
