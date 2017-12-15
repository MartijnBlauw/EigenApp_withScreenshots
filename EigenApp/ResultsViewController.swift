//
//  ResultsViewController.swift
//  EigenApp
//
//  This screen shows the results of de quiz.
//
//  Created by Martijn Blauw on 13-12-17.
//  Copyright © 2017 Martijn Blauw. All rights reserved.
//

import UIKit
import Firebase

class ResultsViewController: UIViewController {

    var correctAnswered: Int?
    var ref = Database.database().reference(withPath: "scores")
    let userOnline = Auth.auth().currentUser?.email
    
    
    @IBOutlet weak var correctAnsweredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the amount of correct answers
        guard let correctAnswered = correctAnswered else { return }
        correctAnsweredLabel.text = "Correct answers: \(correctAnswered)."
        
        // Save the score of the user 
        guard let userOnline = userOnline else { return }
        let score = Score(name: userOnline, score: correctAnswered)
        self.ref.childByAutoId().setValue(score.toAnyObject())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
