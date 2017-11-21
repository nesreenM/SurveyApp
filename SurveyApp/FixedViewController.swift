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

    override func viewDidLoad() {
        super.viewDidLoad()
//            label.text = DataModel.sharedInstance.questionsGreen[DataModel.sharedInstance.currentIndexGreen]
//            DataModel.sharedInstance.currentIndexGreen += 1
        // Do any additional setup after loading the view.
        let rightTappedGesture = UITapGestureRecognizer(target: self, action: #selector(rightTapped))
        arrowImageView.addGestureRecognizer(rightTappedGesture)
        arrowImageView.isUserInteractionEnabled = true
        
        let leftTappedGesture = UITapGestureRecognizer(target: self, action: #selector(leftTapped))

        leftArrowImage.addGestureRecognizer(leftTappedGesture)
        leftArrowImage.isUserInteractionEnabled = true

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

    
    @IBAction func selectedButton(_ sender: Any) {
        let btn = sender as! UIButton
       
//        btn.isHighlighted = true
//        btn.isSelected = true
        btn.isSelected = !btn.isSelected
    
            choiceImageView.image = btn.imageView?.image
       

    }
}

