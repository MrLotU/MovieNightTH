//
//  ViewController.swift
//  MovieNight
//
//  Created by Jari Koopman on 09/05/2017.
//  Copyright © 2017 JarICT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GenreDelegate {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    var personOneDone: Bool = false
    var personTwoDone: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for genre in genres {
            getMovies(byGenre: genre)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if personOneDone && personTwoDone {
            for movie in getResults() {
                print(movie.title)
            }
        }
    }
    
    func setImage(_ image: UIImage, forPerson1 person1: Bool) {
        if person1 {
            button1.setImage(image, for: .normal)
        } else {
            button2.setImage(image, for: .normal)
        }
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        selectGenres(sender)
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
        }
    }
}

