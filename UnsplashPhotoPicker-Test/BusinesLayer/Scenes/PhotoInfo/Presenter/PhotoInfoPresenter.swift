//
//  PhotoInfoPresenter.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 18/10/22.
//

import Foundation

protocol PhotoInfoPresenterDelegate: BaseViewControllerProtocol {
    
}

class PhotoInfoPresenter {
    
    weak var delegate: PhotoInfoPresenterDelegate?
    
    public func setViewDelegate(delegate: PhotoInfoPresenterDelegate) {
        self.delegate = delegate
    }
    
}
