//
//  SurveyApp
//
//  Created by Nesreen Mamdouh on 11/20/17.
//  Copyright © 2017 JRany. All rights reserved.
//
 
import UIKit
import Bubbles
import SpriteKit

class FloatingViewController: UIViewController {

    @IBOutlet weak var leftArrow: UIImageView!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var bubblesView: CSBubblesView!
    @IBOutlet weak var questionEmoji: UIImageView!
    @IBOutlet weak var question: UILabel!
    var selectedAnswers :[String] = []
    var changed = false
    var loaded = false
    
    var delegate : SwipeDelegate?
    var currentQuestionID = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rightTappedGesture = UITapGestureRecognizer(target: self, action: #selector(rightTapped))
        arrowImageView.addGestureRecognizer(rightTappedGesture)
        arrowImageView.isUserInteractionEnabled = true
        
        let leftTappedGesture = UITapGestureRecognizer(target: self, action: #selector(leftTapped))
        leftArrow.addGestureRecognizer(leftTappedGesture)
        leftArrow.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.bubbleWasSelected), name: NSNotification.Name(rawValue: "BubbleWasSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.bubbleWasDeselected), name: NSNotification.Name(rawValue: "BubbleWasDeselected"), object: nil)
        loaded = true
        
        question.text = DataModel.sharedInstance.getQuestionByID(id: currentQuestionID)?.body
        
    }
    @objc func rightTapped() {
    delegate?.swipedRight()
    }
    @objc func leftTapped(){
        delegate?.swipedLeft()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        if (loaded) {
            var answersArray : [String] = []
            let answers = DataModel.sharedInstance.getQuestionByID(id: currentQuestionID)?.answer
            for a in answers! {
                answersArray.append(a.body)
            }
            self.bubblesView.dataArray = NSMutableArray(array: answersArray)
            loaded = false
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        for selected in selectedAnswers{
            let id = getAnswerByBody(body: selected)
            if (DataModel.sharedInstance.questionAnswerDictionary[currentQuestionID] != nil) {
                DataModel.sharedInstance.questionAnswerDictionary[currentQuestionID]?.append(id)
            }
            else
            {
               DataModel.sharedInstance.questionAnswerDictionary[currentQuestionID] = [id]
            }
            
        }
    }
    @objc func bubbleWasSelected(notification: NSNotification) {
        print(notification.object as! String)
        selectedAnswers.append(notification.object as! String)
        
    }
    
    @objc func bubbleWasDeselected(notification: NSNotification) {

        print(notification.object as! String)
        let deselectedAnswer = notification.object as! String
        let deselectedIndex = selectedAnswers.index(of: deselectedAnswer)
        selectedAnswers.remove(at: deselectedIndex!)
        
        print("Deselected " , selectedAnswers)
        
    }
    func getAnswerByBody(body:String) -> Int{
        let answerArray = DataModel.sharedInstance.getQuestionByID(id: currentQuestionID)?.answer
        for answer in answerArray!{
            if answer.body == body{
                return answer.id
            }
        }
        return 0
    
    }

}
