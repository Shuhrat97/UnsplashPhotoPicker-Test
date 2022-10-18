//
//  TabBar.swift
//  Food-Delivery
//
//  Created by Shuhrat Nurov on 14/10/22.

import UIKit
class TabBar: UITabBarController {
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavControllers(for: PhotoPickerViewController(), title: "Photos", image: UIImage(systemName: "photo.fill")),
            createNavControllers(for: FavouritePhotosViewController(), title: "Favourites", image: UIImage(systemName: "heart.fill"))
        ]
    }
    
    fileprivate func createNavControllers(for rootViewController:UIViewController, title:String, image:UIImage?)->UIViewController{
        let navController = UINavigationController(rootViewController: rootViewController)  
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
}
