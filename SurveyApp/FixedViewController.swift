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
extension UIButton {
    
    func centerVertically(padding: CGFloat = 16) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 10.0,
            bottom: (titleLabelSize.height+padding) ,
            right:10
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 10,
            left: 0,
            bottom: -(totalHeight-titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: 0,
            right: 0.0
        )
    }
    
}
