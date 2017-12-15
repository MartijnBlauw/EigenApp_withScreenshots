//
//  ScoresTableViewController.swift
//  EigenApp
//
//  This screen shows the user all the scores
//
//  Created by Martijn Blauw on 14-12-17.
//  Copyright © 2017 Martijn Blauw. All rights reserved.
//

import UIKit
import Firebase

class ScoresTableViewController: UITableViewController {

    var scores: [Score] = []
    var ref = Database.database().reference(withPath: "scores")
    
    // Logout
    @IBAction func logOutButtonTapped(_ sender: UIBarButtonItem) {
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "backToBegin", sender: self)
    }
    
    // Load the data from the database 
    override func viewDidLoad() {
        super.viewDidLoad()
        ref.observe(.value) { snapshot in
            var newScore: [Score] = []
            
            for item in snapshot.children {
                let score = Score(snapshot: item as! DataSnapshot)
                newScore.append(score)
            }

            self.scores = newScore
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)

        // The table should display the name and score of the users, now it only displays the name
        let score = scores[indexPath.row]
        cell.textLabel?.text = score.name

        return cell
    }
    
}
