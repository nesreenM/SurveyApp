//
//  GreetingViewController.swift
//  SurveyApp
//
//  Created by Rana on 11/20/17.
//  Copyright © 2017 JRany. All rights reserved.
//

import UIKit

class GreetingViewController: UIViewController,NetworkRequestsCompletionHandler {
  

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rateMe(_ sender: Any) {
        
        NetworkRequests().getActiveQuestions(sender: self)
        
        
    }
    func onCompleteUpdateView(_ methodName: String) {
        print("Success \(methodName)")
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        present(vc, animated: true, completion: nil)
    }
    
    func onErrorUpdateView(_ errorMessage: String, _ methodName: String) {
        print("Error \(methodName) \(errorMessage)")
    }
   
    
}
