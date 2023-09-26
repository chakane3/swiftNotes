//
//  ViewController.swift
//  GuessingGame
//
//  Created by Chakane Shegog on 9/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    let guessingGameModel = GuessingGameModel()
    var enteredGuesses: Set<String> = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self // this connects the extension to our view controller; the textfield methods will be "delegated" here
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions and Methods
    @IBAction func submitGuessButtonPressed(_ sender: UIButton) {
        // when the user enters a guess and hits submit we wanr to change the label and tell the user if theyre correct or not
//        playGame()
        
        let userInput = inputTextField.text ?? ""
        
        enteredGuesses.insert(userInput)
        let guessNumber = Int(userInput) ?? 0
        let result = guessingGameModel.gameResult(guessNumber)
        messageLabel.text = result == .correct ? "Correct guess" : "Incorrect guess"
        
        
    }
    
    
    // This is one way to do it
    func playGame() {
        // 1. Check if the message label is null
        if(inputTextField.text! == "") {
            print("Message label was blank")
        } else {
            // 2. Tell the user if theyre correct or not
            let gameInstance = GuessingGameModel()
            if let userGuess = Int(inputTextField.text!) {
                let result = gameInstance.gameResult(userGuess)
                let actualNumber = gameInstance.winningNum
                if result == GuessOutcome.incorrect {
                    messageLabel.text = "You lost :c\nThe winning number was \(actualNumber)"
                } else {
                    messageLabel.text = "You won!"
                }
            } else {
                messageLabel.text = "Something went wrong, userguess wasnt converted"
            }
        }
    }
}


// MARK: - UITextFieldDelegate Methods
extension ViewController: UITextFieldDelegate {
    
    // This functions runs when the user first touches the textfield
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    
    // youll be able to limit how many characters a user enters, validate characters, whatever u want with the characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // differenciating between multiple text fields
        // if textField == inputTextField { }
        guard let text = textField.text else {
            return false
        }
        let currentText = text + string // string is a character each time we type
        if enteredGuesses.contains(currentText) {
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        // dismiss the keyboard
        textField.resignFirstResponder()
        playGame()
        // clear the text field
        textField.text=""
        return true
    }
}

