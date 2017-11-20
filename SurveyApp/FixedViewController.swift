//
//  GreenViewController.swift
//  SurveyApp
//
//  Created by Nesreen Mamdouh on 11/20/17.
//  Copyright © 2017 JRany. All rights reserved.
//

import UIKit

class FixedViewController: UIViewController {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var greatButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var mehButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var terribleButton: UIButton!
    
    var delegate : SwipeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
            label.text = DataModel.sharedInstance.questionsGreen[DataModel.sharedInstance.currentIndexGreen]
            DataModel.sharedInstance.currentIndexGreen += 1
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        arrowImageView.addGestureRecognizer(tap)
        arrowImageView.isUserInteractionEnabled = true
        terribleButton.titleEdgeInsets = UIEdgeInsetsMake((terribleButton.imageView?.image?.size.height)!, 0, 0, 0)

    }
    @objc func tapped (){
        delegate?.swipedRight()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
