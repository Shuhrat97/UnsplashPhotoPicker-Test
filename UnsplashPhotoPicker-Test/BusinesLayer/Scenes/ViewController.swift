//
//  ViewController.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private let testLabel:UILabel = {
        let lbl = UILabel()
        lbl.text = "Test"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var searchText = ""
    private var isFiltered = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(testLabel)
        
        
        testLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
//        search.searchBar.delegate = self
        self.navigationItem.searchController = search
    }


}



extension ViewController: UISearchControllerDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = ""
        isFiltered = false
//        self.tableView.reloadData()
    }
}

