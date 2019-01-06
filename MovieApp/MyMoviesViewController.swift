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

class MyMoviesViewController: UIViewController, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    var data = DataViewModel()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var endpoint:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        data.setEndpoint(self.endpoint) { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func filterContentForSearchText (searchText: String) {
        data.filterVideos(with: searchText) { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data.selectVideo(at: indexPath.row) { [unowned self] in
            self.performSegue(withIdentifier: "moveToSecondVC", sender: self)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToSecondVC" {
            let destination = segue.destination as! MovieDetailViewController
            if let selected = data.getSelectedVideo() {
                destination.video = selected
            }
        }
    }

}

extension MyMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.getMovieListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! FirstTableViewCell
        
        if let item = data.getItemBy(indexPath.row) {
            cell.binding(title: item.name, content: item.content, thumbnailUrl: item.imgURL)
        }
        return cell
    }
}

