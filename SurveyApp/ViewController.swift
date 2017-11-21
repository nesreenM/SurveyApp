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
class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var bubblesView: CSBubblesView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(self.bubbleWasSelected), name: NSNotification.Name(rawValue: "BubbleWasSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.bubbleWasDeselected), name: NSNotification.Name(rawValue: "BubbleWasDeselected"), object: nil)
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.bubblesView.dataArray = NSMutableArray(array: ["Argentina", "Aruba", "Australia", "Austria", "Bahamas","Argentina", "Aruba", "Australia", "Austria", "Bahamas","Argentina", "Aruba", "Waiters response time", "Cleaniness", "Food service"])
        

    }
    @objc func bubbleWasSelected(notification: NSNotification) {
        print(notification.object as! String)
        questionLabel.text = ""

        questionLabel.fadeTransition(0.8)
        questionLabel.text = "Rate our waiters please"
    }
    
    @objc func bubbleWasDeselected(notification: NSNotification) {
        print(notification.object as! String)
    }

}



