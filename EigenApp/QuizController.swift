//
//  QuizController.swift
//  EigenApp
//
//  Here all data is loaded from the API.
//
//  Created by Martijn Blauw on 08-12-17.
//  Copyright © 2017 Martijn Blauw. All rights reserved.
//

import Foundation
import UIKit

class QuizController {
    
    func fetchQuiz(completion: @escaping (Quiz?) -> Void) {
        let url = URL(string: "https://opentdb.com/api.php?amount=20&difficulty=medium&type=multiple")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let quizDictionary = try? jsonDecoder.decode(Quiz.self, from: data) {
                completion(quizDictionary)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
