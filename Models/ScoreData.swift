//
//  ScoreData.swift
//  
//
//  Created by Martijn Blauw on 15-12-17.
//

import Foundation
import Firebase

struct Score {
    
    let key: String
    let name: String
    let ref: DatabaseReference?
    let score: Int

    init(name: String, score: Int, key: String = "") {
        self.key = key
        self.name = name
        self.ref = nil
        self.score = score
    }
    
    init(snapshot: DataSnapshot){
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        ref = snapshot.ref
        score = snapshotValue["score"] as! Int
    }
        
    func toAnyObject() -> Any {
        return [
            "name": name,
            "score": score
        ]
    }
}
