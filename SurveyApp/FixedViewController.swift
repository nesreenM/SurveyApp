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
        
        if (DataModel.sharedInstance.questionAnswerTuple[currentQuestionID] != nil) {
            DataModel.sharedInstance.questionAnswerTuple[currentQuestionID]?.append(
                getAnswerByValue(value: selectedAnswer))
        }else{
            DataModel.sharedInstance.questionAnswerTuple[currentQuestionID] =
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
    @IBAction func selectedButton(_ sender: Any) {
        let btn = sender as! UIButton
        btn.isSelected = !btn.isSelected
//        if btn.isSelected {
            switch btn.restorationIdentifier {
            case "terrible"?:
                if btn.isSelected{
                    btn.setImage(UIImage(named: "terrible"), for: .normal)
                    selectedAnswer = 1

                }else{
                    btn.setImage(UIImage(named: "terribleEmoji"), for: .normal)

                }
                return
            case "bad"?:
                if btn.isSelected{
                    selectedAnswer = 2
                    btn.setImage(UIImage(named: "bad"), for: .normal)
                    
                }else{
                    btn.setImage(UIImage(named: "badEmoji"), for: .normal)
                    
                }
                return
            case "meh"?:
                if btn.isSelected{
                    selectedAnswer = 3
                    btn.setImage(UIImage(named: "meh"), for: .normal)
                    
                }else{
                    btn.setImage(UIImage(named: "mehEmoji"), for: .normal)
                    
                }
                return
            case "good"?:
                if btn.isSelected{
                    selectedAnswer = 4
                    btn.setImage(UIImage(named: "good"), for: .normal)

                    
                }else{
                    btn.setImage(UIImage(named: "goodEmoji"), for: .normal)
                }
                return
            case "great"?:
                if btn.isSelected{
                    selectedAnswer = 5
                    btn.setImage(UIImage(named: "great"), for: .normal)
                    
                }else{
                    btn.setImage(UIImage(named: "greatEmoji"), for: .normal)

                    
                }
                return
                
            default:
                btn.imageView?.image = UIImage()
            }
//        }
        
       

    }
}

