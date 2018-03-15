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
    
    @IBOutlet weak var timerText: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var button1 : UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    var quizQuestions = QuizQuestions()
    @objc let questionsPerRound = 4
    @objc var questionsAsked = 0
    @objc var correctQuestions = 0
    @objc var randomQuestionIndex: Int = 0
  
    
    // Timer Variables
    var seconds = 15
    var timer = Timer()
    var isTimerRunning = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        QuizSounds().loadGameStartSound()
        QuizSounds().loadCheerSound()
        QuizSounds().loadBooSound()
        QuizSounds().playGameStartSound()
        displayQuestion()
        runTimer()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func displayQuestion() {
        runTimer()
        resetTimer()
       
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        
        randomQuestionIndex = quizQuestions.randomIndex()
        questionField.text = quizQuestions.questions[randomQuestionIndex].question
        
        playAgainButton.isHidden = true
        button4.isHidden = true
        button3.isHidden = true
        button1.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        button1.setTitle(quizQuestions.questions[randomQuestionIndex].answerChoices[0], for: .normal)
        button2.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        button2.setTitle(quizQuestions.questions[randomQuestionIndex].answerChoices[1], for: .normal)
        
        if quizQuestions.questions[randomQuestionIndex].answerChoices.count > 2 {
            button3.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
            button3.setTitle(quizQuestions.questions[randomQuestionIndex].answerChoices[2], for: .normal)
            button3.isHidden = false
        }
        if quizQuestions.questions[randomQuestionIndex].answerChoices.count > 3 {
            button4.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
            button4.setTitle(quizQuestions.questions[randomQuestionIndex].answerChoices[3], for: .normal)
            button4.isHidden = false
        }
        view.backgroundColor =  UIColor(red: 8/255.0, green: 43/255.0, blue: 62/255.0, alpha: 1.0)
    }
    

    @objc func displayScore() {
        removeTimer()
        
        // Hide the answer buttons

        
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "You got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    

    @IBAction func checkAnswer(_ sender: UIButton) {
        
        removeTimer()
     
        // Increment the questions asked counter, display question result and change button colours.
        
        let currentAnswer = sender.currentTitle!
        questionsAsked += 1
        let selectedQuestion = quizQuestions.questions[randomQuestionIndex]
        shuffleQuestions()
        let correctAnswer: String? = selectedQuestion.answer
       
        if currentAnswer == correctAnswer {
        correctQuestions += 1
          
            questionField.text = "Correct!"
            QuizSounds().playCheerSound()
            view.backgroundColor =  UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0)
        } else {
            questionField.text = "Sorry, wrong answer! The correct answer was:"
             QuizSounds().playBooSound()
            view.backgroundColor =  UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0)
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
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        button4.isEnabled = false
    }
    
    @objc func nextRound() {
        if questionsAsked == questionsPerRound {
            resetQuestions()
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
    func shuffleQuestions() {
        quizQuestions.answeredQuestions.append(quizQuestions.questions[randomQuestionIndex])
        quizQuestions.questions.remove(at: randomQuestionIndex)
    }
    
    func resetQuestions() {
        quizQuestions.questions.append(contentsOf: quizQuestions.answeredQuestions)
        quizQuestions.answeredQuestions.removeAll()
    }
    
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
    
    
    //timer
    
    @objc func runTimer() {
        timerText.text = "Time Left:"
        timerLabel.isHidden = false
         timerText.isHidden = false
        if isTimerRunning == false
        {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
        }
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        
        
       
        if seconds < 1 {
            
            isTimerRunning = false
            timer.invalidate()
            QuizSounds().playBooSound()
            questionsAsked += 1
            shuffleQuestions()
            nextRound()
            
        } else {
            seconds -= 1     //This will decrement(count down)the seconds.
            timerLabel.text = "\(seconds)" //This will update the label.
        }
        
        if seconds < 5 {
            timerText.text = "HURRY UP!"
        }
        
    }
    
    func resetTimer() {
       // timer.invalidate()
        seconds = 15    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.text = "\(seconds)"
        
    }
    
    func removeTimer() {
        timer.invalidate()
        timerLabel.isHidden = true
        timerText.isHidden = true
        isTimerRunning = false
    }
    
    
}

