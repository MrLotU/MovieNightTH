//
//  MoviesTableViewController.swift
//  MovieNight
//
//  Created by Jari Koopman on 23/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    let results = getResults()
    var delegate: MovieNightDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start over", style: .done, target: self, action: #selector(done))
    }
    
    func done() {
        delegate.startOver()
        self.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        
        cell.titleLabel.text = results[indexPath.row].title
        let genres = results[indexPath.row].genres
        var genresLabelText = ""
        if !genres.isEmpty {
            for genre in genres {
                genresLabelText += "\(genre.name), "
            }
            genresLabelText.characters.removeLast()
            cell.genresLabel.text = genresLabelText
        } else {
            cell.genresLabel.text = "Maybe you should try again!"
        }
        results[indexPath.row].getImage { (image) in
            cell.moviePoster.image = image
        }
        
        return cell
    }
}
