//
//  FavouritePhotosPresenter.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import Foundation

protocol FavouritePhotosPresenterDelegate: BaseViewControllerProtocol {
    func presentPhotos(_ photos: [Photo])
}

class FavouritePhotosPresenter {
    
    weak var delegate: FavouritePhotosPresenterDelegate?
    
    public func setViewDelegate(delegate: FavouritePhotosPresenterDelegate) {
        self.delegate = delegate
        NotificationCenter.default.addObserver(self,selector:#selector(getPhotos),name:NSNotification.Name("favouritePhotosUpdated"),object: nil)
    }
    
    @objc func getPhotos(){
        let photos = Array(UserPreferences.shared.favouritePhotos)
        self.delegate?.presentPhotos(photos)
    }
    
}

