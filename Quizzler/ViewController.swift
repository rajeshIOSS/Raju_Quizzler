//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var count : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstQuestion = allQuestions.list[count]
        questionLabel.text = firstQuestion.questionText
        updateUI()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2{
            pickedAnswer = false
        }
        checkAnswer()
        
        count = count + 1
        nextQuestion()
        updateUI()
        
        
    }
    
    
    func updateUI() {
      scoreLabel.text = "Score \(score)"
        progressLabel.text = String("\(count + 1)/13")
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(count)
    }
    

    func nextQuestion() {
        if count == 12 {
            let alert = UIAlertController(title: "Awesome", message: "You have finished all the question do you want to start again ?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
            
        }else {
            let firstQuestion = allQuestions.list[count]
            questionLabel.text = firstQuestion.questionText
        }
        
        
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[count].answer
        if correctAnswer == pickedAnswer {
            score += 1
            ProgressHUD.showSuccess("Correct")
        }else {
            print("N")
            ProgressHUD.showError("Wrong")
        }
    }
    
    
    func startOver() {
       count = 0
        nextQuestion()
        updateUI()
    }
    

    
}
