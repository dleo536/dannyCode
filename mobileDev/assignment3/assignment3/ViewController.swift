//
//  ViewController.swift
//  assignment3
//
//  Created by Leo, Daniel Christopher on 9/25/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var showAnswer: UIButton!
    @IBOutlet weak var nextQuestion: UIButton!
    var questions:[String] = []
    var answers:[String] = []
    var currentQuestionIndex:Int = -1
    var isQuestionDisplayed:Bool = true
    
    
    
    @IBAction func tapNext(_ sender:AnyObject){

            question.text = questions[currentQuestionIndex]
            showAnswer.setTitle("Show Answer", for: UIControlState.normal)
            isQuestionDisplayed = true
            answer.text = ""
        }

    @IBAction func tapShow(_ sender:AnyObject){
        if isQuestionDisplayed{
            answer.text = answers[currentQuestionIndex]
            showAnswer.setTitle("Show Answer", for: UIControlState.normal)
            currentQuestionIndex = Int(arc4random_uniform(UInt32(questions.count)))
            isQuestionDisplayed = false
            
    }
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions.append("What is the capitol of Alaska?")
        answers.append("Juneau")
        questions.append("What is the capitol of Conneticut?")
        answers.append("Hartford")
        questions.append("What is the capitol of Kentucky?")
        answers.append("Frankfort")
        questions.append("What is the capitol of Pennsylvania?")
        answers.append("Harrison")
        questions.append("What is the capitol of Vermont?")
        answers.append("Montpelier")
        currentQuestionIndex = Int(arc4random_uniform(UInt32(questions.count)))
        question.text = questions[currentQuestionIndex]
        answer.text = ""
        
    
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

