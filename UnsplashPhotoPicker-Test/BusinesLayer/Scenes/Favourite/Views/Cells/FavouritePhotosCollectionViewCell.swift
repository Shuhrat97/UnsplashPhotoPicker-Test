//
//  FavouritePhotosCollectionViewCell.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import UIKit
import SDWebImage

class FavouritePhotoCollectionViewCell:UICollectionViewCell{
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
    
    private let textLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13)
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let containerView:UIView = {
        let vW = UIView()
        vW.clipsToBounds = true
        vW.layer.cornerRadius = 10
        vW.backgroundColor = UIColor.black.withAlphaComponent(0)
        vW.translatesAutoresizingMaskIntoConstraints = false
        return vW
    }()
    
    let gradient: CAGradientLayer = CAGradientLayer()
    
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
        
        imageView.addSubview(containerView)
        imageView.addSubview(textLabel)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        containerView.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor,
                           UIColor.black.withAlphaComponent(0).cgColor,
                           UIColor.black.withAlphaComponent(0).cgColor,
                           UIColor.black.withAlphaComponent(0).cgColor,
                           UIColor.black.withAlphaComponent(0.9).cgColor]
        containerView.layer.addSublayer(gradient)
    }
    
    func reload(photo:Photo){
        let url = URL(string: photo.urls.regular)
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        textLabel.text = photo.user.name
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        gradient.frame = contentView.bounds
    }
}
