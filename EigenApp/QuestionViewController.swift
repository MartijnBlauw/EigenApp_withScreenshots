//
//  QuestionViewController.swift
//  EigenApp
//
//  This screen loads and displays all the questions and answers.
//
//  Created by Martijn Blauw on 09-12-17.
//  Copyright © 2017 Martijn Blauw. All rights reserved.
//


import UIKit

class QuestionViewController: UIViewController {
    
    let quizController = QuizController()
    var quizData: Quiz?
    var questionIndex = 0
    var correctAnswered = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        // Keep track of the correct answers
        if let quizData = quizData {
            if quizData.results[questionIndex].correct_answer == sender.titleLabel?.text {
                correctAnswered += 1
                nextQuestion()
            } else {
                nextQuestion()
            }
        }
    }
    
    func nextQuestion() {
        // Update the amount of question and go to the next screen, when all questions are answered
        if let quizData = quizData {
            questionIndex += 1
            
            if questionIndex < quizData.results.count {
                updateUI()
            } else {
                performSegue(withIdentifier: "ResultsSegue", sender: nil)
            }
        }
    }
    
    func updateUI() {
        if let quizData = quizData {
            // Merge the correct and incorrect answers in a array en sort them
            let currentQuestion = quizData.results[questionIndex]
            var all_answers: [String] = currentQuestion.incorrect_answers
            all_answers.append(currentQuestion.correct_answer)
            all_answers = all_answers.sorted()
            
            // Set the label and button with the question and the answers
            DispatchQueue.main.async {
                self.questionLabel.text = currentQuestion.question
                self.button1.setTitle(all_answers[0], for: .normal)
                self.button2.setTitle(all_answers[1], for: .normal)
                self.button3.setTitle(all_answers[2], for: .normal)
                self.button4.setTitle(all_answers[3], for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizController.fetchQuiz { (data) in
            if let data = data {
                self.quizData = data
            }
        }
        
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send the amount of correct answers to the next screen
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.correctAnswered = correctAnswered
        }
    }
}
