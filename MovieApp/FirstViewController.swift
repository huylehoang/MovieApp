//
//  ViewController.swift
//  MovieApp
//
//  Created by LeeX on 7/8/17.
//  Copyright © 2017 LeeX. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var names = ["The Revenant","The Hateful Eight","THe Big Short"]
    
    var contents = ["hadjfhklasjdfhkljsdhfksjahdfkakjshdfkjahsdfkjhaskldfjhaksldhfaklsdhfklasfhlakjflkajsflkajsflkasjflajsflkjsfljalsfjalksfjlasjflasjflkjsalfjalskjghkljashgkjahfgkjhakfjghkghkashgkahsdkgahskdghaksgdhkashdgkajshdgkjashdgkjahsdkgjhaksjghakjsdhgkjashdgkjahsdgkjahsdkgjhaksldghaklghdkalsdhgkashdgkakgdh",
                   "jasdlfjooqwejoiprjwqfopijoqpwijfoiqjweofijqopiejfoqpjfojlnznlcxvnlznzlncvlnhsdofiuyopqwuprejlknxcljvkjhxofqwhogihosiagjoisajfoiiqnewiocmoinqronvqoiwjoiqmweoijfoiqjwiofjqwoifheoiqhewfoihqwoiefhqowiefhoqihwfeoiqwhfoihqwoeifhqoiefhqoiwehfoiqhfoqfh",
                   "jasdfkjhaslkjdfhkajlsdhfkljahsdkfjlhaskdjfhkajsdhfkljhkahjsjkdfhaskaksjhdfkashfdhgoihsdoifgjsdoifgjoisdjfgoisjdfgoijsdogijsdogjosdjfgosdjfgoisdjgfosdjogfjsdoifgjsdoijgiosdjgfoisdjfogijsdiogfjsdopgjfosdijgoisdjgfoisdjfgoijsdfoigjdfoivdjoijfoiajfoijsodifjaosjfoapsjfdoasjdfoiajsdofjsaofpjdaosijfoiajfoisdjfoiajsdfoijasofijasdofijasoidfj"]
    
    var images = [UIImage(named: "TheRevenant"),UIImage(named: "TheHatefulEight"),UIImage(named: "TheBigShort")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        createSearchBar()
        
        
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! FirstTableViewCell
        
        cell.videoThumnailImageView.image = images[indexPath.row]
        cell.videoTitle.text = names[indexPath.row]
        cell.videoContent.text = contents[indexPath.row]
        
        return cell
         
    }
}

