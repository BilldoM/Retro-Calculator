//
//  ViewController.swift
//  retro-calculator
//
//  Created by William Melvin on 3/28/16.
//  Copyright © 2016 William Melvin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValueStr = ""
    var rightValueStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    var clear = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
       processOperation(Operation.Empty)
        outputLabel.text = "0"
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //run some math
            
            //user selected operator but then selected another without entering a number
            if runningNumber != "" {
            rightValueStr = runningNumber
            runningNumber = ""
            
                
                    
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValueStr)! * Double(rightValueStr)!)"
            } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueStr)! / Double(rightValueStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValueStr)! + Double(rightValueStr)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValueStr)! - Double(rightValueStr)!)"
                } else if currentOperation == Operation.Empty {
                
                }
                
            leftValueStr = result
            outputLabel.text = result
        }
        
            currentOperation = op
            
        } else {
            //This is the first operator being pressed
            leftValueStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }

}


