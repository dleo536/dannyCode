//
//  ViewController.swift
//  MemeMe
//
//  Created by Leo, Daniel Christopher on 10/7/18.
//  Copyright © 2018 Leo, Daniel Christopher. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var instructions:UILabel = UILabel()
    var imageView:UIImageView = UIImageView()
    var lowerText:UITextView = UITextView()
    var upperText:UITextView = UITextView()
    var keyboardHeight:Int = Int()
    var bottomOfText:Int = Int()
    var topOfKeyboard:Int = Int()
    var viewMove:Bool = Bool()
    var textViewMoved:Bool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        lowerText.delegate = self
        upperText.delegate = self
        addInstructions()
        addGestureRecognizer()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addInstructions(){
        instructions.frame = CGRect(x: 0, y: view.frame.height-100, width: view.frame.width, height: 100)
        instructions.text = "Tap anywhere to select an image"
        instructions.textAlignment = NSTextAlignment.center
        view.addSubview(instructions)
    }
    func addImageView(){
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        view.addSubview(imageView)
        
    }
    func addTextViews(){
        let impactFont:UIFont? = UIFont(name: "Impact", size: 24)
        upperText.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 75)
        upperText.text = "Set it up..."
        upperText.font = impactFont
        upperText.textColor = UIColor.white
        upperText.layer.shadowColor = UIColor.black.cgColor
        upperText.layer.shadowOffset = CGSize(width: 2, height: 2)
        upperText.layer.shadowOpacity = 1.0
        upperText.layer.shadowRadius = 2.0
        upperText.backgroundColor = UIColor.clear
        upperText.textAlignment = NSTextAlignment.center
        
        
        lowerText.frame = CGRect(x: 0, y: view.frame.height-75, width: view.frame.width, height: 75)
        lowerText.text = "... and knock it down"
        lowerText.font = impactFont
        lowerText.textColor = UIColor.white
        lowerText.layer.shadowColor = UIColor.black.cgColor
        lowerText.layer.shadowOffset = CGSize(width: 2, height: 2)
        lowerText.layer.shadowOpacity = 1.0
        lowerText.layer.shadowRadius = 2.0
        lowerText.backgroundColor = UIColor.clear
        lowerText.textAlignment = NSTextAlignment.center
        
        view.addSubview(upperText)
        view.addSubview(lowerText)
//        let drag = UIPanGestureRecognizer(target: self, action: #selector(labelDragged))
//        let drag2 = UIPanGestureRecognizer(target: self, action: #selector(labelDragged))
//
//        lowerText.addGestureRecognizer(drag)
//        upperText.addGestureRecognizer(drag2)
        
        
    }
    func addGestureRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        view.addGestureRecognizer(tap)
//        adding a gestureRecognizer to UITextLabels but UITextLabel.self didn't work
        let drag = UIPanGestureRecognizer(target: self, action: #selector(labelDragged))
        let drag2 = UIPanGestureRecognizer(target: self, action: #selector(labelDragged))
        
        lowerText.addGestureRecognizer(drag)
        upperText.addGestureRecognizer(drag2)
        
    }
    @objc func screenTapped(){
        let imagePickerViewController:UIImagePickerController = UIImagePickerController()
        imagePickerViewController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            imagePickerViewController.sourceType = UIImagePickerControllerSourceType.camera
            
        }else {
            imagePickerViewController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        present(imagePickerViewController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image:UIImage! = info[UIImagePickerControllerOriginalImage] as! UIImage
        if !view.subviews.contains(imageView){
            addImageView()
        }
        imageView.image = image
        if !view.subviews.contains(upperText){
            addTextViews()
        }
        instructions.isHidden = true
        dismiss(animated: true, completion: nil)
        
    }


    @objc func keyboardWillBeShown(_ sender: Notification){
        let info:NSDictionary = sender.userInfo! as NSDictionary
        let value:NSValue? = info.value(forKey: UIKeyboardFrameEndUserInfoKey) as? NSValue
        if value!.cgRectValue.height != 0 {
            keyboardHeight = Int(value!.cgRectValue.height)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("This is the keyboard height: \(keyboardHeight)")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
       NotificationCenter.default.removeObserver(self)
        
    }
//
    func moveView(moveUp:Bool) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)  //REPLACE <?> BELOW
        view.frame = self.view.frame.offsetBy(dx: 0, dy: moveUp ? CGFloat(-keyboardHeight): CGFloat(keyboardHeight))
        UIView.commitAnimations()

    }
//
    func textViewDidBeginEditing(_ textView: UITextView){
//        topOfKeyboard = keyboardHeight
        let bottomOfText = Int(view.frame.height - textView.frame.minY)
        viewMove = true
        if  keyboardHeight > bottomOfText{
            moveView(moveUp: true)
            textViewMoved = true
            viewMove = false
        }
    }
    func textViewDidEndEditing(_ textView: UITextView){

        if textViewMoved {
            moveView(moveUp: viewMove)
            viewMove = true

        }
        view.endEditing(true)

    }
    @objc func labelDragged(_ sender:AnyObject?) {
        let gesture:UIPanGestureRecognizer = sender as! UIPanGestureRecognizer
        let textView:UITextView = gesture.view as! UITextView
        let translation:CGPoint = gesture.translation(in: textView)
        textView.center = CGPoint(x:textView.center.x, y:textView.center.y+translation.y)
        gesture.setTranslation(CGPoint.zero, in: textView)

    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        //Update the image view frame to cover the new screen size using CGRect
        let newHeight:CGFloat = view.frame.height/5
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        lowerText.frame = CGRect(x: 0, y: view.frame.height - newHeight, width: view.frame.width, height: 75)
        upperText.frame = CGRect(x: 0, y: newHeight, width: view.frame.width, height: 75)
        
        }
    }
    

