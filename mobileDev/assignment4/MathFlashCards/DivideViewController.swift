//
//  ViewController.swift
//  MathFlashCards
//
//  Created by Leo, Daniel Christopher on 10/2/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import UIKit

class DivideViewController: UIViewController {

    @IBOutlet weak var operand1Label: UILabel!
    @IBOutlet weak var operand2Label: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    let underlineView:UIView = UIView()
    let underlineView2:UIView = UIView()
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
        if (!answerLabel.subviews.contains(underlineView) && !answerLabel.subviews.contains(underlineView2)){
            underlineView.frame = CGRect(x: operand2Label.frame.width, y: operand2Label.frame.height, width: (operand2Label.frame.width) , height: 5)
            underlineView.backgroundColor = UIColor.black
            underlineView2.frame = CGRect(x: operand2Label.frame.width, y: operand2Label.frame.height, width: 5 , height: operand2Label.frame.height)
            underlineView2.backgroundColor = UIColor.black
            answerLabel.addSubview(underlineView)
            answerLabel.addSubview(underlineView2)
       
        }
    }
    
    func generateEquation (){
        let operand1:Int = Int(arc4random_uniform(9)) + 1
        var divided:Int = Int(arc4random_uniform(9)) + 1
        let operand2:Int = operand1 * divided
        operand1Label.text = String(operand1)
        operand2Label.text = String(operand2)
        answerLabel.text = ""
        answer = String(divided)
    }
    @IBAction func screenTapped(){
        if answerLabel.text!.isEmpty {
            answerLabel.text = answer
        }else{
            generateEquation()
            
        }
    }

}
