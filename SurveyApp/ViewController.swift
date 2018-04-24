//
//  ViewController.swift
//  SurveyApp
//
//  Created by Nesreen Mamdouh on 11/20/17.
//  Copyright © 2017 JRany. All rights reserved.
//

import UIKit
import Bubbles
import SpriteKit
class ViewController: UIViewController,NetworkRequestsCompletionHandler{

    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = submitButton.layer.bounds.height / 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitAction(_ sender: Any) {
        for question in DataModel.sharedInstance.activeQuestions
        {
            print("Answers ", DataModel.sharedInstance.questionAnswerDictionary[question.id])
//            let selectedAnswers = DataModel.sharedInstance.questionAnswerDictionary[question.id]
//            NetworkRequests().postResponse(questionId: question.id, answerId: selectedAnswers!, responseId: 1 , sender: self)
        }
    }
    func onCompleteUpdateView(_ methodName: String) {
        print("Success \(methodName)")
        
        
    }
    
    func onErrorUpdateView(_ errorMessage: String, _ methodName: String) {
        print("Error \(errorMessage) \(methodName)")
    }
    
}



