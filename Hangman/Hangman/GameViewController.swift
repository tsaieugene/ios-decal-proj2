//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var hangmanImage: UIImageView!
    
    @IBOutlet var displayLabel: UILabel!
    
    @IBOutlet var letterGuessed: UITextField!
    
    @IBOutlet var incorrectGuesses: UILabel!

    var phraseArray: [String] = []
    
    var guessesArray: [String] = []
    
    var displayArray: [String] = []
    
    let alphabetArray: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var numberOfIncorrectGuesses = 0
    
    var hangmanCounter = 1
    
    var gameOver = false
    
    @IBAction func newGamePressed(sender: AnyObject) {
        phraseArray = []
        guessesArray = []
        displayArray = []
        numberOfIncorrectGuesses = 0
        hangmanCounter = 1
        gameOver = false
        self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        var phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        
        incorrectGuesses.text = "Incorrect Guesses:"
        
        for char in phrase.characters {
            phraseArray.append("\(char)")
        }
        print(phraseArray)
        
        displayLabel.text = ""
        for char in phrase.characters {
            if char == " " {
                displayArray.append(" ")
                
            } else {
            displayArray.append("_")
            }
        }
        displayLabel.text = displayArray.joinWithSeparator(" ")
        print(displayArray)
    }

    @IBAction func guessPressed(sender: AnyObject) {
        if gameOver {
            if !displayArray.contains("_") {
                displayGameWonAlert()
            }
            displayGameOverAlert()
        }
        var letter = letterGuessed.text
        if !alphabetArray.contains(letter!) || letter!.characters.count != 1 {
            displayInvalidGuessAlert()
        }
        
        var index = 0
        if phraseArray.contains(letter!) && !guessesArray.contains(letter!) && alphabetArray.contains(letter!) && !gameOver{
            guessesArray.append(letter!)
            displayCorrectGuessAlert()
            while index < phraseArray.count {
                if phraseArray[index] == letter {
                    displayArray[index] = letter!
                    displayLabel.text = displayArray.joinWithSeparator(" ")
                }
                index++
            }
            if !displayArray.contains("_") {
                gameOver = true
            }
        } else if !phraseArray.contains(letter!) && !guessesArray.contains(letter!) && alphabetArray.contains(letter!) && !gameOver{
            guessesArray.append(letter!)
            numberOfIncorrectGuesses += 1
            hangmanCounter += 1
            incorrectGuesses.text = incorrectGuesses.text! + " " + "\(letter!)"
            displayIncorrectGuessAlert()
            hangmanImage.image = UIImage(named: "hangman\(hangmanCounter).gif")
            if numberOfIncorrectGuesses == 6 {
                gameOver = true
            }
        } else {
            displayAlreadyGuessedAlert()
        }
        print(displayArray)
        letterGuessed.text = ""
    }
    
    func displayInvalidGuessAlert() {
        let invalidGuessAlert = UIAlertController(title: "Alert", message: "Guess One Capitalized Letter", preferredStyle: UIAlertControllerStyle.Alert)
        let guessAgain = UIAlertAction(title: "Guess Again", style: .Cancel) { action -> Void in
        }
        invalidGuessAlert.addAction(guessAgain)
        self.presentViewController(invalidGuessAlert, animated: true, completion: nil)
    }
    
    func displayAlreadyGuessedAlert() {
        let displayAlreadyGuessedAlert = UIAlertController(title: "Alert", message: "Letter Already Guessed Before", preferredStyle: UIAlertControllerStyle.Alert)
        let guessAgain = UIAlertAction(title: "Guess Again", style: .Cancel) { action -> Void in
        }
        displayAlreadyGuessedAlert.addAction(guessAgain)
        self.presentViewController( displayAlreadyGuessedAlert, animated: true, completion: nil)
    }
    
    func displayCorrectGuessAlert() {
        let displayCorrectGuessAlert = UIAlertController(title: "Good Job!", message: "Correct Guess!", preferredStyle: UIAlertControllerStyle.Alert)
        let guessAgain = UIAlertAction(title: "Guess Again", style: .Cancel) { action -> Void in
        }
        displayCorrectGuessAlert.addAction(guessAgain)
        self.presentViewController(displayCorrectGuessAlert, animated: true, completion: nil)
    }
    
    func displayIncorrectGuessAlert() {
        let displayIncorrectGuessAlert = UIAlertController(title: "Sorry!", message: "Incorrect Guess!", preferredStyle: UIAlertControllerStyle.Alert)
        let guessAgain = UIAlertAction(title: "Guess Again", style: .Cancel) { action -> Void in
        }
        displayIncorrectGuessAlert.addAction(guessAgain)
        self.presentViewController(displayIncorrectGuessAlert, animated: true, completion: nil)
    }
    
    func displayGameOverAlert() {
        let displayGameOverAlert = UIAlertController(title: "You Lose!", message: "Try Again!", preferredStyle: UIAlertControllerStyle.Alert)
        let close = UIAlertAction(title: "Close", style: .Cancel) { action -> Void in
        }
        displayGameOverAlert.addAction(close)
        self.presentViewController(displayGameOverAlert, animated: true, completion: nil)
    }
    
    func displayGameWonAlert() {
        let displayGameOverAlert = UIAlertController(title: "You Win!", message: "Play Again!", preferredStyle: UIAlertControllerStyle.Alert)
        let close = UIAlertAction(title: "Close", style: .Cancel) { action -> Void in
        }
        displayGameOverAlert.addAction(close)
        self.presentViewController(displayGameOverAlert, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
