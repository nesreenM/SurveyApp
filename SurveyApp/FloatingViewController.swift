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
            self.bubblesView.dataArray = DataModel.sharedInstance.choices
            loaded = false
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        DataModel.sharedInstance.choices.removeObjects(in: selectedAnswers)

    }
    @objc func bubbleWasSelected(notification: NSNotification) {
        print(notification.object as! String)
        selectedAnswers.append(notification.object as! String)
        
    }
    
    @objc func bubbleWasDeselected(notification: NSNotification) {
        print("@@@@")

        print(notification.object as! String)
        let deselectedAnswer = notification.object as! String
        let deselectedIndex = selectedAnswers.index(of: deselectedAnswer)
        selectedAnswers.remove(at: deselectedIndex!)
        
        print("Deselected " , selectedAnswers)
        
    }

}
