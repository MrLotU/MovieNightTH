//
//  ViewController.swift
//  MovieNight
//
//  Created by Jari Koopman on 09/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MovieNightDelegate {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var viewResultsButton: UIButton!
    var personOneDone: Bool = false
    var personTwoDone: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for genre in genres {
            getMovies(byGenre: genre)
        }
        viewResultsButton.isEnabled = false
        viewResultsButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if personOneDone && personTwoDone {
            viewResultsButton.isEnabled = true
            viewResultsButton.isHidden = false
        }
    }
    
    func setImage(_ image: UIImage, forPerson1 person1: Bool) {
        if person1 {
            button1.setImage(image, for: .normal)
        } else {
            button2.setImage(image, for: .normal)
        }
    }
    
    func startOver() {
        viewResultsButton.isEnabled = false
        viewResultsButton.isHidden = true
        button1.setImage(UIImage(named: "bubble-empty"), for: .normal)
        button2.setImage(UIImage(named: "bubble-empty"), for: .normal)
        personOneDone = false
        personTwoDone = false
        person1Genres = []
        person2Genres = []
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender == button1 || sender == button2 {
            selectGenres(sender)
        } else if sender == viewResultsButton {
            viewMovies()
        }
    }
    
    func viewMovies() {
        performSegue(withIdentifier: "showMovies", sender: nil)
    }
    
    func selectGenres(_ sender: UIButton) {
        performSegue(withIdentifier: "showGenres", sender: sender)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGenres" {
            let newVC = segue.destination as! GenreTableViewController
            newVC.delegate = self
            let button = sender as! UIButton
            if button == button1 {
                newVC.person1 = true
            } else {
                newVC.person1 = false
            }
        } else if segue.identifier == "showMovies" {
            let newVC = segue.destination as! MoviesTableViewController
            newVC.delegate = self
        }
    }
}

