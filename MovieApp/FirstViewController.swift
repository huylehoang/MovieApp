//
//  ViewController.swift
//  MovieApp
//
//  Created by LeeX on 7/8/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit
import AFNetworking

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchResultsUpdating, Delegate {

    @IBOutlet weak var tableView: UITableView!
    
    var data = DataModel()
    
//    var names:[String] = []
//    
//    var contents:[String] = []
//    
//    var imgURLArray:[String] = []
    
    var videos:[Video] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredArray:[Video] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        
        data.delegate = self
        data.fetchDataMovie()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        navigationItem.titleView = searchController.searchBar

    }
    
    func filterContentForSearchText (searchText: String) {
        filteredArray = videos.filter({ (video) -> Bool in
            return video.name.contains(searchText)
        })
        
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    
//    func didReceiveDataNames(dataNames: [String]) {
//        self.names = dataNames
//        self.tableView.reloadData()
//    }
//    
//    func didReceiveDataContens(dataContents: [String]) {
//        self.contents = dataContents
//        self.tableView.reloadData()
//    }
//    
//    func didReceiveDataImages(dataImages: [String]) {
//        self.imgURLArray = dataImages
//        self.tableView.reloadData()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveData(data: [Video]) {
        self.videos = data
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""  {
            return self.filteredArray.count
        } else {
            return self.videos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! FirstTableViewCell
        
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.videoTitle.text = filteredArray[indexPath.row].name
        } else {
            cell.videoTitle.text = self.videos[indexPath.row].name
        }
        cell.videoContent.text = self.videos[indexPath.row].content

        
        let imgURL = NSURL(string: self.videos[indexPath.row].imgURL)
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.videoThumnailImageView.image = UIImage(data: data as! Data)
        }
        return cell
         
    }
}

