//
//  ViewController.swift
//  MovieApp
//
//  Created by LeeX on 7/8/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit
import AFNetworking
import Alamofire
import AlamofireImage

class MyMoviesViewController: UIViewController, UISearchResultsUpdating, Delegate{

    @IBOutlet weak var tableView: UITableView!
    
    var data = DataModel()
    
    var videos:[Video] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredArray:[Video] = []
    
    var endpoint:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        data.delegate = self
        data.endpoint = self.endpoint
        data.fetchDataMovie()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }
    
    func filterContentForSearchText (searchText: String) {
        filteredArray = videos.filter({ (video) -> Bool in
            return video.name.lowercased().contains(searchText.lowercased())
        })
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didReceiveData(data: [Video]) {
        self.videos = data
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToSecondVC", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToSecondVC" {
            let destination = segue.destination as! MovieDetailViewController
            let indexPath = tableView.indexPathForSelectedRow!
            
            destination.video = self.videos[indexPath.row]
        }
    }

}

extension MyMoviesViewController: UITableViewDataSource, UITableViewDelegate {
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
            cell.videoContent.text = filteredArray[indexPath.row].content
            Alamofire.request(filteredArray[indexPath.row].imgURL).responseImage { response in
                
                if let image = response.result.value {
                    cell.videoThumnailImageView.image = image
                }
            }

        } else {
            cell.videoTitle.text = self.videos[indexPath.row].name
            cell.videoContent.text = self.videos[indexPath.row].content
            Alamofire.request(self.videos[indexPath.row].imgURL).responseImage { response in
                
                if let image = response.result.value {
                    cell.videoThumnailImageView.image = image
                }
            }
        }
//        let imgURL = NSURL(string: self.videos[indexPath.row].imgURL)
//
//        if imgURL != nil {
//            let data = NSData(contentsOf: (imgURL as? URL)!)
//            cell.videoThumnailImageView.image = UIImage(data: data as! Data)
//        }
        return cell
    }
}

