//
//  ViewController.swift
//  Number Generator Hackwich
//
//  Created by rkatakam on 3/9/16.
//  Copyright © 2016 Rohan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Tap Gesture created on ImageView
        //When ImageView tapped, call "imageTapped" method
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //Method called when Tap Gesture on ImageView tapped
    func imageTapped(img: AnyObject){
        rollDice(randomNumbersArray())
    }
    
    //Method that creates a random array of 3 numbers
    func randomNumbersArray() -> [Int]{
        //Array to be returned by method
        var randomNumbers : [Int] = []
        //3 number variables to hold random numbers from 1 to 6
        var num1 = Int(arc4random_uniform(6) + 1)
        var num2 = Int(arc4random_uniform(6) + 1)
        var num3 = Int(arc4random_uniform(6) + 1)
        
        //While loop to make sure all three numbers are different (it loops while one of the numbers equals another)
        while((num1 == num2) || (num1 == num3) || (num2 == num3)){
            //if all numbers are different, end the loop
            if((num1 != num2) && (num1 != num3) && (num2 != num3)){
                break
            } else {
                //if numbers are same, randomize again
                num1 = Int(arc4random_uniform(6) + 1)
                num2 = Int(arc4random_uniform(6) + 1)
                num3 = Int(arc4random_uniform(6) + 1)
            }
        }
        
        //Add different random numbers to randomNumbers
        randomNumbers.append(num3)
        randomNumbers.append(num2)
        randomNumbers.append(num1)
        
        //Return randomNumbers
        return randomNumbers
    }
    
    //Method to set the image of the ImageView
    func setDiceImage(number: Int){
        //Set dice image to correspond to number from parameter
        if(number == 1){
            imageView.image = UIImage(named: "die1")
        } else if(number == 2){
            imageView.image = UIImage(named: "die2")
        } else if(number == 3){
            imageView.image = UIImage(named: "die3")
        } else if(number == 4){
            imageView.image = UIImage(named: "die4")
        } else if(number == 5){
            imageView.image = UIImage(named: "die5")
        } else if(number == 6){
            imageView.image = UIImage(named: "die6")
        }
    }
    
    //Method to roll the dice given an array of random numbers
    func rollDice(randomNumbers: [Int]){
        //Set the header label to rolling at the beginning of the function to be shown while the function is running
        headerLabel.text = "ROLLING.."
        
        //Set dice image to the first random number
        setDiceImage(randomNumbers[0])
        
        //Create a timer to perform code after 1 second
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            //Code to execute after 1 second
            ///Set dice image to second random number after 1 second
            self.setDiceImage(randomNumbers[1])
            
            //Create anothe timer to perform code after another second
            let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
            dispatch_after(time, dispatch_get_main_queue()) {
                //Code to execute after another second
                ///Set dice image to final random number after another second
                self.setDiceImage(randomNumbers[2])
                //Set header label to dispay the number the dice finally landed on
                self.headerLabel.text = "LANDED ON \(randomNumbers[2])"
            }
        }
    }
}
