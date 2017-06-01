//
//  GenreTableViewController.swift
//  MovieNight
//
//  Created by Jari Koopman on 23/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class GenreTableViewController: UITableViewController {

    var delegate: MovieNightDelegate!
    var person1: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.title = "Select Genres"
    }
    
    func done() {
        var selectedGenres: [Genre] = []
        for item in tableView.visibleCells {
            let cell = item as! GenreTableViewCell
            if cell.genreIsSelected {
                selectedGenres.append(cell.genre)
            }
        }
        if person1 {
            person1Genres = selectedGenres
        } else {
            person2Genres = selectedGenres
        }
        if selectedGenres == [] {
            if person1 {
                self.delegate.personOneDone = false
            } else {
                self.delegate.personTwoDone = false
            }
            self.delegate.setImage(UIImage(named: "bubble-empty")!, forPerson1: person1)
        } else {
            self.delegate.setImage(UIImage(named: "bubble-selected")!, forPerson1: person1)
            if person1 {
                self.delegate.personOneDone = true
            } else {
                self.delegate.personTwoDone = true
            }
        }
        self.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell", for: indexPath) as! GenreTableViewCell
        
        cell.titleLabel.text = genres[indexPath.row].name
        if person1 {
            if person1Genres.contains(genres[indexPath.row]) {
                cell.checker.image = UIImage(named: "Checked")
                cell.genreIsSelected = true
            } else {
                cell.checker.image = UIImage(named: "Unchecked")
            }
        } else {
            if person2Genres.contains(genres[indexPath.row]) {
                cell.checker.image = UIImage(named: "Checked")
                cell.genreIsSelected = true
            } else {
                cell.checker.image = UIImage(named: "Unchecked")
            }
        }
        cell.genre = genres[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GenreTableViewCell
        switch cell.genreIsSelected {
        case true:
            cell.checker.image = UIImage(named: "Unchecked")
            cell.genreIsSelected = false
        case false:
            cell.checker.image = UIImage(named: "Checked")
            cell.genreIsSelected = true
        }
    }

}
