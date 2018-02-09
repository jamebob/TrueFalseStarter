//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let quizQuestions = QuizQuestions()
    @objc let questionsPerRound = 4
    @objc var questionsAsked = 0
    @objc var correctQuestions = 0
    @objc var randomQuestionIndex: Int = 0
    
    @objc var gameSound: SystemSoundID = 0
    

    
   
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func displayQuestion() {
        button1.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        button2.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        button3.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        button4.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        view.backgroundColor =  UIColor(red: 8/255.0, green: 43/255.0, blue: 62/255.0, alpha: 1.0)
        randomQuestionIndex = quizQuestions.randomIndex()
        questionField.text = quizQuestions.questions[randomQuestionIndex].question
        playAgainButton.isHidden = true
        
        button1.setTitle(quizQuestions.questions[randomQuestionIndex].answerChoices[0], for: .normal)
        button2.setTitle(quizQuestions.questions[randomQuestionIndex].answerChoices[1], for: .normal)
        button3.setTitle(quizQuestions.questions[randomQuestionIndex].answerChoices[2], for: .normal)
        button4.setTitle(quizQuestions.questions[randomQuestionIndex].answerChoices[3], for: .normal)
    }
    

    
    @objc func displayScore() {
        // Hide the answer buttons
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
       
        // Increment the questions asked counter
        let currentAnswer = sender.currentTitle!
        questionsAsked += 1
        let selectedQuestion = quizQuestions.questions[randomQuestionIndex]
        let correctAnswer = selectedQuestion.answer
        if currentAnswer == correctAnswer {
            
            correctQuestions += 1
          
            questionField.text = "Correct!"
            view.backgroundColor =  UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
        } else {
            questionField.text = "Sorry, wrong answer! The correct answer was:"
            view.backgroundColor =  UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0)
            //print(button3.currentTitle)
        }
        
       if button1.currentTitle == correctAnswer {
           button1.backgroundColor = UIColor(red: 85/255.0, green: 150/255.0, blue: 112/255.0, alpha: 1.0)
        }
       else if button2.currentTitle == correctAnswer {
            button2.backgroundColor = UIColor(red: 85/255.0, green: 150/255.0, blue: 112/255.0, alpha: 1.0)
        }
       else if button3.currentTitle == correctAnswer {
            button3.backgroundColor = UIColor(red: 85/255.0, green: 150/255.0, blue: 112/255.0, alpha: 1.0)
        }
       else if button4.currentTitle == correctAnswer {
            button4.backgroundColor = UIColor(red: 85/255.0, green: 150/255.0, blue: 112/255.0, alpha: 1.0)
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    @objc func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    @objc func loadNextRoundWithDelay(seconds: Int) {
        
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    @objc func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    @objc func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

