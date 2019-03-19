//
//  PageViewController.swift
//  ImageRecognition_CVProject
//
//  Created by AbdulHadi Al-Ajmi on 11/12/18.
//  Copyright © 2018 AbdulHadi Al-Ajmi. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource{

    
    lazy var orderedViewConrollers: [UIViewController] = {
        return [self.newVc(viewController: "sbIamge"),
                self.newVc(viewController: "sbVideo")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        if let firstViewController = orderedViewConrollers.first{
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewConrollers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewConrollers.last
        }
        
        guard orderedViewConrollers.count > previousIndex else {
            return nil
        }
        
        return orderedViewConrollers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewConrollers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewConrollers.count != nextIndex else {
            return orderedViewConrollers.first
        }
        
        guard orderedViewConrollers.count > nextIndex else {
            return nil
        }
        
        return orderedViewConrollers[nextIndex]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
