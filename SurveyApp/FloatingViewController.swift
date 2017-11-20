//
//  RedViewController.swift
//  SurveyApp
//
//  Created by Nesreen Mamdouh on 11/20/17.
//  Copyright © 2017 JRany. All rights reserved.
//

import UIKit
import Bubbles
import SpriteKit

class FloatingViewController: UIViewController {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var bubblesView: CSBubblesView!
    @IBOutlet weak var questionEmoji: UIImageView!
    @IBOutlet weak var question: UILabel!
    
    var delegate : SwipeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        arrowImageView.addGestureRecognizer(tap)
        arrowImageView.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.bubbleWasSelected), name: NSNotification.Name(rawValue: "BubbleWasSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.bubbleWasDeselected), name: NSNotification.Name(rawValue: "BubbleWasDeselected"), object: nil)
        
        
    }
    @objc func tapped() {
    delegate?.swipedRight()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
       
         self.bubblesView.dataArray = NSMutableArray(array: ["Food Flavor", "Food Variety", "Service", "Food Tempreture", "Seating Timing","Manager Greeting", "Waiters response time", "Cleaniness", "Food service"])
        
    }
    @objc func bubbleWasSelected(notification: NSNotification) {
        print(notification.object as! String)
        
    }
    
    @objc func bubbleWasDeselected(notification: NSNotification) {
        print(notification.object as! String)
    }

}
