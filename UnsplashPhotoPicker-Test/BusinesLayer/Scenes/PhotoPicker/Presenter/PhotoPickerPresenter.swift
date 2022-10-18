//
//  PhotoPicker.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import UIKit

protocol PhotoPickerPresenterDelegate: BaseViewControllerProtocol {
    func presentPhotos(_ photos: [Photo])
    func presentFilteredPhotos(_ photos: [Photo], totalPages:Int)
}

class PhotoPickerPresenter {
    
    weak var delegate: PhotoPickerPresenterDelegate?
    
    public func setViewDelegate(delegate: PhotoPickerPresenterDelegate) {
        self.delegate = delegate
    }
    
    func getPhotos(page:Int){
        if page == 1 {
            delegate?.preloader(show: true)
        }
        guard let url = URL(string: "https://api.unsplash.com/photos?client_id=Y6K_62ADJzbvTIbxGaNUWmkkTg4WogjulU15f9VF9-A&page=\(page)&per_page=25") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode([Photo].self, from: data)
                self.delegate?.presentPhotos(model)
            } catch {
                self.delegate?.showError(message: error.localizedDescription)
            }
            
            
        }
        task.resume()
    }
    
    func getFilteredPhotos(text:String,page:Int){
        if page == 1 {
            delegate?.preloader(show: true)
        }
        let text = text.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: "https://api.unsplash.com/search/photos?client_id=Y6K_62ADJzbvTIbxGaNUWmkkTg4WogjulU15f9VF9-A&page=\(page)&per_page=25&query=\(text)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(FilterResponse.self, from: data)
                self.delegate?.presentFilteredPhotos(model.results, totalPages: model.totalPages)
            } catch {
                self.delegate?.showError(message: error.localizedDescription)
            }
        }
        task.resume()
    }
}

