//
//  GreenViewController.swift
//  SurveyApp
//
//  Created by Nesreen Mamdouh on 11/20/17.
//  Copyright © 2017 JRany. All rights reserved.
//

import UIKit

class FixedViewController: UIViewController {
    
    @IBOutlet weak var leftArrowImage: UIImageView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var greatButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var mehButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var terribleButton: UIButton!
    
    @IBOutlet weak var choiceImageView: UIImageView!
    var delegate : SwipeDelegate?
    var currentQuestionID = 0
    var selectedAnswer = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightTappedGesture = UITapGestureRecognizer(target: self, action: #selector(rightTapped))
        arrowImageView.addGestureRecognizer(rightTappedGesture)
        arrowImageView.isUserInteractionEnabled = true
        
        let leftTappedGesture = UITapGestureRecognizer(target: self, action: #selector(leftTapped))
        
        leftArrowImage.addGestureRecognizer(leftTappedGesture)
        leftArrowImage.isUserInteractionEnabled = true
        label.text = DataModel.sharedInstance.getQuestionByID(id: currentQuestionID)?.body
        
        terribleButton.setImage(UIImage(named: "terrible"), for: .selected)
        
        terribleButton.setImage(UIImage(named: "terribleEmoji"), for: .normal)

        badButton.setImage(UIImage(named: "bad"), for: .selected)
        
        badButton.setImage(UIImage(named: "badEmoji"), for: .normal)

        mehButton.setImage(UIImage(named: "meh"), for: .selected)
        
        mehButton.setImage(UIImage(named: "mehEmoji"), for: .normal)

        goodButton.setImage(UIImage(named: "good"), for: .selected)
        
        goodButton.setImage(UIImage(named: "goodEmoji"), for: .normal)

        greatButton.setImage(UIImage(named: "great"), for: .selected)
        
        greatButton.setImage(UIImage(named: "greatEmoji"), for: .normal)

        
    }
    @objc func rightTapped (){
        delegate?.swipedRight()
        
    }
    @objc func leftTapped(){
        delegate?.swipedLeft()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        if (DataModel.sharedInstance.questionAnswerDictionary[currentQuestionID] != nil) {
            DataModel.sharedInstance.questionAnswerDictionary[currentQuestionID]?.append(
                getAnswerByValue(value: selectedAnswer))
        }else{
            DataModel.sharedInstance.questionAnswerDictionary[currentQuestionID] =
                [getAnswerByValue(value: selectedAnswer)]
        }
        
        
        
        
    }
    
    func getAnswerByValue(value:Int) -> Int{
        
        let answers = DataModel.sharedInstance.getQuestionByID(id: currentQuestionID)?.answer
        for answer in answers! {
            if answer.value == value {
                return answer.id
            }
        }
        return 0
        
    }
    func unSelectButtons(btn:UIButton){
        
        switch btn.restorationIdentifier {
        case "terrible"?:
            greatButton.isSelected = false
            goodButton.isSelected = false
            mehButton.isSelected = false
            badButton.isSelected = false
            return
        case "bad"?:
            greatButton.isSelected = false
            goodButton.isSelected = false
            mehButton.isSelected = false
            terribleButton.isSelected = false
            
            return
        case "meh"?:
            greatButton.isSelected = false
            goodButton.isSelected = false
            badButton.isSelected = false
            terribleButton.isSelected = false
            return
        case "good"?:
            greatButton.isSelected = false
            mehButton.isSelected = false
            badButton.isSelected = false
            terribleButton.isSelected = false
            return
        case "great"?:
            goodButton.isSelected = false
            mehButton.isSelected = false
            badButton.isSelected = false
            terribleButton.isSelected = false
            return
            
        default:
            btn.imageView?.image = UIImage()
        }
    }
    @IBAction func selectedButton(_ sender: Any) {
        let btn = sender as! UIButton
        unSelectButtons(btn: btn)
        btn.isSelected = !btn.isSelected
        
        switch btn.restorationIdentifier {
        case "terrible"?:
            if btn.isSelected{
                selectedAnswer = 1

            }
            return
        case "bad"?:
            if btn.isSelected{
                selectedAnswer = 2

            }
            return
        case "meh"?:
            if btn.isSelected{
                selectedAnswer = 3

            }
            return
        case "good"?:
            if btn.isSelected{
                selectedAnswer = 4
            }
            return
        case "great"?:
            if btn.isSelected{
                selectedAnswer = 5
            }
            return

        default:
            btn.imageView?.image = UIImage()
        }

        
        
    }
}

