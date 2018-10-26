//
//  SecondViewController.swift
//  MathFlashCards
//
//  Created by Leo, Daniel Christopher on 9/27/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import UIKit

class SubtractViewController: UIViewController {

    @IBOutlet weak var operand1Label: UILabel!
    @IBOutlet weak var operand2Label: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    let underlineView:UIView = UIView()
    var answer:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateEquation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !answerLabel.subviews.contains(underlineView){
            underlineView.frame = CGRect(x: 0, y: 0, width: answerLabel.frame.width, height: 5)
            underlineView.backgroundColor = UIColor.black
            answerLabel.addSubview(underlineView)
        }
    }
    
    func generateEquation (){
        let operand1:Int = Int(arc4random_uniform(99)) + 1
        let operand2:Int = Int(arc4random_uniform(99)) + 1
        
        operand1Label.text = String(operand1)
        operand2Label.text = String(operand2)
        answerLabel.text = ""
        answer = String(operand1 - operand2)
    }
    @IBAction func screenTapped(){
        if answerLabel.text!.isEmpty {
            answerLabel.text = answer
        }else{
            generateEquation()
            
        }
    }
}

