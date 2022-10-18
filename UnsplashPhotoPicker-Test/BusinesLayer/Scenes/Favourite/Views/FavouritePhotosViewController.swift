//
//  FavouritePhotosViewController.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import UIKit

class FavouritePhotosViewController:UIViewController {
    
    private let collectionView:UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(FavouritePhotoCollectionViewCell.self, forCellWithReuseIdentifier: "FavouritePhotoCollectionViewCell")
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = true
        return collection
    }()
    
    private let presenter = FavouritePhotosPresenter()
    
    private var photos:[Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setViewDelegate(delegate: self)
        presenter.getPhotos()
        
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
                
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                       heightDimension: .fractionalHeight(1.0)))
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(1.0)),
                    subitem: item, count: 2)
                
                let nestedGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalHeight(0.5)),
                    subitem: group, count: 2)
                
                let section = NSCollectionLayoutSection(group: nestedGroup)
                return section
        }
        return layout
    }

}

extension FavouritePhotosViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouritePhotoCollectionViewCell", for: indexPath) as? FavouritePhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell?.reload(photo: photo)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        let ctrl = PhotoInfoViewController(photo: photo)
        ctrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
    
}

extension FavouritePhotosViewController:FavouritePhotosPresenterDelegate{
    
    func presentPhotos(_ photos: [Photo]) {
        DispatchQueue.main.async{
            self.photos = photos
            self.collectionView.reloadData()
        }
    }
    
}
