//
//  PhotoInfoViewController.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 18/10/22.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    private let presenter = PhotoInfoPresenter()
    
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
    
    private let usernameLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let dateLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let locationLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let downloadsLabel:UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let photo: Photo

    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isFavourite()->Bool{
        let isFavourite = UserPreferences.shared.favouritePhotos.contains { item in
            item.id == photo.id
        }
        return isFavourite
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.setViewDelegate(delegate: self)
        
        setupRightBtn()
        
        setupViews()

        let url = URL(string: photo.urls.regular)
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        
        usernameLabel.text = "Username: " + photo.user.name
        dateLabel.text = "Created date: " + (photo.createdAt.toDate()?.toString() ?? "")
        locationLabel.text = "Location: " + (photo.user.location ?? "")
        downloadsLabel.text = "Likes: " + String(photo.likes)
        
    }
    
    private func setupRightBtn(){
        let image = isFavourite() ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        let rightBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(favouriteBtnTapped))
        
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func setupViews(){
        view.addSubview(imageView)
        view.addSubview(usernameLabel)
        view.addSubview(dateLabel)
        view.addSubview(locationLabel)
        view.addSubview(downloadsLabel)

        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        imageView.layoutIfNeeded()
        let width = imageView.frame.width
        let height:CGFloat = (CGFloat(photo.height)*width)/CGFloat(photo.width)
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        downloadsLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        downloadsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        downloadsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func favouriteBtnTapped(){
        let title = isFavourite() ? "Do you want remove from favorites?" : "Do you want add to favourite?"
        showAlert(viewCtrl: self, title: "Message", message: title, okTitle: "Yes", cancelTitle: "No") { isOk in
            if self.isFavourite() {
                if isOk{
                    UserPreferences.shared.favouritePhotos.remove(self.photo)
                    self.setupRightBtn()
                }
            } else {
                if isOk{
                    UserPreferences.shared.favouritePhotos.insert(self.photo)
                    self.setupRightBtn()
                }
            }
        }
    }
    
}

extension PhotoInfoViewController: PhotoInfoPresenterDelegate{
    
}
