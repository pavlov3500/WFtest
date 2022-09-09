import UIKit

// MARK: - TableView Delegate

extension FavViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.favList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as? FavCell else {return UITableViewCell()}
        cell.configure(fav: DataManager.favList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height / 7
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = DataManager.favList[indexPath.row].id else {return}
        getInfo(id: id)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
        DataManager.setFavList {
            DataManager.favList.remove(at: indexPath.row)
        }
        favTableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
    
}
