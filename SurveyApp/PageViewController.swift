//
//  PageViewController.swift
//  SurveyApp
//
//  Created by Nesreen Mamdouh on 11/20/17.
//  Copyright © 2017 JRany. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController,SwipeDelegate , NetworkRequestsCompletionHandler{
   
    
    var currentIndex = 0
    func swipedLeft() {
        print("Swiped left" , currentIndex , "orderedViewControllers.count " , orderedViewControllers.count )
        //        viewControllers
        if currentIndex > 0 {
            currentIndex -= 1

        }
        if currentIndex > -1 {
            self.setViewControllers([orderedViewControllers[currentIndex]], direction: .reverse, animated: true, completion: nil)
        }
    }
    
    func swipedRight() {
        print("Swiped right" , currentIndex, "orderedViewControllers.count " , orderedViewControllers.count)
//        viewControllers
        if currentIndex < orderedViewControllers.count - 1 {
            currentIndex += 1

        }
        if currentIndex < orderedViewControllers.count {
            self.setViewControllers([orderedViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
        }
        if currentIndex == 5{
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            present(vc, animated: true, completion: nil)
            
        }

    }

    var type : [UIViewController] = []

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        for qs in DataModel.sharedInstance.activeQuestions {
            if !qs.isMultiSelect {
               // 3 green
                let v = self.newVc(name: "FixedViewController") as! FixedViewController
                v.delegate = self
                v.currentQuestionID = qs.id
                self.type.append(v)
            }else{
                let v = self.newVc(name: "FloatingViewController") as! FloatingViewController
                v.delegate = self
                v.currentQuestionID = qs.id
               self.type.append(v)
            }
        }

        return self.type
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        dataSource = self
        UIApplication.shared.statusBarStyle = .lightContent

        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newVc(name:String)->UIViewController{
       let vc =  UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: name)
        
        return vc
       
    }


}

extension PageViewController : UIPageViewControllerDataSource{
  
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        currentIndex = viewControllerIndex
        print("In after" , currentIndex)
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        currentIndex = viewControllerIndex

        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    func onCompleteUpdateView(_ methodName: String) {
        print("Success \(methodName)")

    }
    
    func onErrorUpdateView(_ errorMessage: String, _ methodName: String) {
        print("Error \(errorMessage) \(methodName)")
    }

}
protocol SwipeDelegate{
    func swipedLeft()
    func swipedRight()
}
