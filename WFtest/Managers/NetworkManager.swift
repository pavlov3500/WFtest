import Alamofire

class NetworkManager {
    
    private let basePath = "https://api.unsplash.com/"
    private let searchPath = "search/photos"
    private func infoPath(id:String) -> String {
        return "photos/\(id)"
    }
    
    init(){}
    static var shared = NetworkManager()
    
    // MARK: - Search request
    
    func getSearch(per_page: Int, page: Int, search: String, completion: @escaping(Result<SearchData,AFError>)->()) {
        
        let params: Parameters = [
            "page":"\(page)",
            "per_page":"\(per_page)",
            "query":search]
        
        let headers:HTTPHeaders = [
            "Authorization":"Client-ID zXHvfBZrAl1xg-T-tFqXIoZhVM9U1mxNUfcu1n7auGM"]
        
        AF.request("\(basePath)\(searchPath)",
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers).responseDecodable (of: SearchData.self) { (response) in
                    guard response.error == nil else {
                        if let error = response.error {
                            print("\(response.error?.errorDescription ?? "")")
                            completion(.failure(error))
                        }
                        return
                    }
                    
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                   }
    }
    
    // MARK: - Info request
    
    func getInfo(id: String, completion: @escaping(Result<InfoData,AFError>)->()) {
        
        let headers:HTTPHeaders = [
            "Authorization":"Client-ID zXHvfBZrAl1xg-T-tFqXIoZhVM9U1mxNUfcu1n7auGM"]
        
        AF.request("\(basePath)\(infoPath(id: id))",
                   method: .get,
                   parameters: .none,
                   encoding: URLEncoding.default,
                   headers: headers).responseDecodable(of: InfoData.self) { (response) in
//                    guard response.error == nil else {
//                        if let error = response.error {
//                            print("\(response.error?.errorDescription ?? "")")
//                            completion(.failure(error))
//                        }
//                        return
//                    }
                    
                    switch response.result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                   }
    }
    
}


    
    
    
    
    
    
    
    
    
    

