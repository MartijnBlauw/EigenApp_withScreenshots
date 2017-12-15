//
//  QuestionData.swift
//  EigenApp
//
//  Created by Martijn Blauw on 11-12-17.
//  Copyright © 2017 Martijn Blauw. All rights reserved.
//

import Foundation
import UIKit

struct Quiz: Codable {
    var response_code: Int
    var results: [Results]
    
    enum CodingKeys: String, CodingKey {
        case response_code
        case results
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.response_code = try valueContainer.decode(Int.self, forKey: CodingKeys.response_code)
        self.results = try valueContainer.decode([Results].self, forKey: CodingKeys.results)
    }
}

struct Results: Codable {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correct_answer
        case incorrect_answers
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.category = try valueContainer.decode(String.self, forKey: CodingKeys.category)
        self.type = try valueContainer.decode(String.self, forKey: CodingKeys.type)
        self.difficulty = try valueContainer.decode(String.self, forKey: CodingKeys.difficulty)
        self.question = try valueContainer.decode(String.self, forKey: CodingKeys.question)
        self.correct_answer = try valueContainer.decode(String.self, forKey: CodingKeys.correct_answer)
        self.incorrect_answers = try valueContainer.decode([String].self, forKey: CodingKeys.incorrect_answers)
    }
}


