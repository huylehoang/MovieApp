//
//  ViewController.swift
//  MovieApp
//
//  Created by LeeX on 7/8/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit
import AFNetworking

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, Delegate {

    @IBOutlet weak var tableView: UITableView!
    
    var data = DataModel()
    
    var names:[String] = []
    
    var contents:[String] = []
    
    var imgURLArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        createSearchBar()
        
        data.delegate = self
        data.fetchDataMovie()

    }
    
    func didReceiveDataNames(dataNames: [String]) {
        self.names = dataNames
        self.tableView.reloadData()
    }
    
    func didReceiveDataContens(dataContents: [String]) {
        self.contents = dataContents
        self.tableView.reloadData()
    }
    
    func didReceiveDataImages(dataImages: [String]) {
        self.imgURLArray = dataImages
        self.tableView.reloadData()
    }
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! FirstTableViewCell
        

        cell.videoTitle.text = names[indexPath.row]
        cell.videoContent.text = contents[indexPath.row]

        
        let imgURL = NSURL(string: imgURLArray[indexPath.row])
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.videoThumnailImageView.image = UIImage(data: data as! Data)
        }
        return cell
         
    }
}

