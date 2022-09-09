import UIKit

// MARK: - TextField Delegate

extension SearchViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        checkConnection()
        let text = textField.text ?? ""
        searchResult.removeAll()
        searchCollectionView.reloadData()
        search = text
        currentPage = 1
        totalPages = currentPage + 1
        return true
    }
}

// MARK: - ScrollView Delegate

extension SearchViewController:UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y
        let height = scrollView.contentSize.height - scrollView.bounds.height + scrollView.contentInset.bottom
        if offset > height && totalPages > currentPage {
            currentPage += 1
            checkConnection()
            UIView.animate(withDuration: 0.3) {
                scrollView.contentOffset.y += 50
            }
        }
        
    }
}

// MARK: - CollectionView Delegate

extension SearchViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else {return UICollectionViewCell()}
        cell.configure(result: searchResult[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 21) / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = searchResult[indexPath.item].id else {return}
        searchCollectionView.isUserInteractionEnabled = false
        getInfo(id: id)
    }
}
