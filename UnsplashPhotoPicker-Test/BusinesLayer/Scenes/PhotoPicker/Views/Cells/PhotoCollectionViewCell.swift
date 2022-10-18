//
//  PhotoCollectionViewCell.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell:UICollectionViewCell{
    private let imageView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.borderColor = UIColor.black.cgColor
        imgView.layer.borderWidth = 0.3
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAndLayoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureAndLayoutSubviews()
    }
    
    func configureAndLayoutSubviews() -> Void {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(imageView)
        
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    func reload(photo:Photo){
        let url = URL(string: photo.urls.regular)
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
    }
}
