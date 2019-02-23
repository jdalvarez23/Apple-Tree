//
//  ViewController.swift
//  Apple Pie
//
//  Created by student19 on 2/19/19.
//  Copyright © 2019 Jose Alvarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"] // initialize and declare array of words
    
    let incorrectMovesAllowed = 7 // initialize and declare number of incorrect guesses per round
    
    // initialize and declare number of total wins
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    // initialize and declare number of total losses
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game! // initialize current game instance [! means that it is okay for the property to not have a  value for a short period]

    // initialize UI component variables
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound() // call method that updates the game state
    }

    // method that executes when the button is pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        sender.isEnabled = false // disable button to prevent the player from selecting multiple letters in one round
        
        let letterString = sender.title(for: .normal)! // set value to button title (normal state)
        
        let letter = Character(letterString.lowercased()) // set value to button title in lowercase Character type format
        
        currentGame.playerGuessed(letter: letter)
        
        updateGameState()
        
    }
    
    // method that begins a new round
    func newRound() {
        // execute if array of words is not empty
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst() // remove first value from array and set constant value to new word
            
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: []) // set value to new instance of Game
            enableLetterButtons(true) // call method that enables buttons
            updateUI() // call method that updates the user interface
        // execute if array of words is empty
        } else {
            enableLetterButtons(false) // call method that enables buttons
        }
        
    }
    
    // method that updates the user interface
    func updateUI() {
        
        var letters = [String]() // initialize letters array
        
        
        
        // loop through all the characters in letter variable
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter)) // append to letters array
        }
        
        let wordWithSpacing = letters.joined(separator: " ") // set value to letters with spacing in between
        
        correctWordLabel.text = wordWithSpacing // set value to formatted word with spacing
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)" // set text label value
        
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)") // set image
        
    }
    
    // method that updates the game state
    func updateGameState() {
        
        // execute if incorrectMovesRemaining equals zero
        if (currentGame.incorrectMovesRemaining == 0) {
            totalLosses += 1 // increment total losses value
            print("PLAYER LOST!")
        // execute if current word is equal to the formatted word
        } else if (currentGame.word == currentGame.formattedWord) {
            totalWins += 1 // increment total wins
        } else {
            updateUI() // call method that updates the user interface
        }
        
    }
    
    // method that enables letter buttons
    func enableLetterButtons(_ enableState: Bool) {
        print("ENABLE LETTER BUTTONS?:", enableState)
        for button in letterButtons {
            button.isEnabled = enableState
        }
    }
    
    
}

