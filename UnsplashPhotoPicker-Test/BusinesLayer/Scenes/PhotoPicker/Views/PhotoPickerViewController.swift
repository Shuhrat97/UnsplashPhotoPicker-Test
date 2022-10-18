//
//  PhotoPickerViewController.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import UIKit

class PhotoPickerViewController:UIViewController {
    
    private let collectionView:UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        return collection
    }()
    
    private var searchText = ""
    private var isFiltered = false
    private var totalPages:Int = 1
    private var filteredPage:Int = 1
    private var filteredPhotos:[Photo] = []
    
    private let presenter = PhotoPickerPresenter()
    
    private var photos:[Photo] = []
    private var page:Int = 1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setViewDelegate(delegate: self)
        presenter.getPhotos(page: page)
        
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        
        setupViews()
        
    }
    
    private func setupViews(){
        view.addSubview(collectionView)
        
        
        collectionView.frame = view.bounds
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.collectionViewLayout = createLayout()
        
    }
    
    private func createLayout() -> UICollectionViewLayout {
            let layout = UICollectionViewCompositionalLayout {
                (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                
                let topLeadingItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3),
                                                       heightDimension: .fractionalHeight(1.0)))
                topLeadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let topTrailingItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(1/3)))
                topTrailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let topTrailingGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                       heightDimension: .fractionalHeight(1.0)),
                    subitem: topTrailingItem, count: 2)
                
                let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2/3)), subitems:[topLeadingItem,topTrailingGroup])
                
                let bottomItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                       heightDimension: .fractionalHeight(1.0)))
                bottomItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let bottomGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .fractionalHeight(1/3)),
                    subitem: topLeadingItem, count: 3)
                
                let nestedGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(0.5)),
                    subitems: [topGroup,bottomGroup])
                
                let section = NSCollectionLayoutSection(group: nestedGroup)
                return section
        }
        return layout
    }

}

extension PhotoPickerViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltered ? filteredPhotos.count : photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell
        let photo = isFiltered ? filteredPhotos[indexPath.row] :  photos[indexPath.row]
        cell?.reload(photo: photo)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isFiltered {
            if indexPath.row == photos.count - 1 && filteredPage < totalPages {
                self.filteredPage += 1
                presenter.getFilteredPhotos(text: self.searchText, page: filteredPage)
            }
        } else {
            if indexPath.row == photos.count - 1 {
                self.page += 1
                presenter.getPhotos(page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = isFiltered ? filteredPhotos[indexPath.row] : photos[indexPath.row]
        let isFavourite = UserPreferences.shared.favouritePhotos.contains { photo in
            photo.id == item.id
        }
        let title = isFavourite ? "Do you want remove from favorites?" : "Do you want add to favourite?"
        showAlert(viewCtrl: self, title: "Message", message: title, okTitle: "Yes", cancelTitle: "No") { isOk in
            if isFavourite {
                if isOk{
                    UserPreferences.shared.favouritePhotos.remove(item)
                }
            } else {
                if isOk{
                    UserPreferences.shared.favouritePhotos.insert(item)
                }
            }
        }
        
    }
}


extension PhotoPickerViewController: UISearchControllerDelegate {
    
    // MARK: - SearchBarCancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = ""
        isFiltered = false
        filteredPage = 1
        self.filteredPhotos = []
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        let str = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !str.isEmpty else {
            self.searchText = ""
            isFiltered = false
            filteredPage = 1
            self.filteredPhotos = []
            self.collectionView.reloadData()
            return
        }
        self.searchText = str
        isFiltered = true
        view.endEditing(true)
        presenter.getFilteredPhotos(text: searchText, page: filteredPage)
    }
}

extension PhotoPickerViewController: UISearchBarDelegate {
    
    // MARK: - SearchBarTextDidChange
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let str = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !str.isEmpty else {
            self.searchText = ""
            isFiltered = false
            filteredPage = 1
            self.filteredPhotos = []
            self.collectionView.reloadData()
            return
        }
        self.searchText = str
        self.filteredPhotos = []
    }
    
}


extension PhotoPickerViewController:PhotoPickerPresenterDelegate{
    func presentFilteredPhotos(_ photos: [Photo], totalPages: Int) {
        DispatchQueue.main.async{
            self.preloader(show: false)
            self.totalPages = totalPages
            self.filteredPhotos.append(contentsOf: photos)
            self.collectionView.reloadData()
        }
    }
    
    func presentPhotos(_ photos: [Photo]) {
        DispatchQueue.main.async{
            self.preloader(show: false)
            self.photos.append(contentsOf: photos)
            self.collectionView.reloadData()
        }
    }
    
}
