//
//  LessonPageViewController.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 04.05.2021.
//

import UIKit

class LessonViewController: UIPageViewController, UIPageViewControllerDataSource
{
    
    var pageViewController : UIPageViewController?
    var pagesDataArray : Array<String> = ["1/3", "2/3", "3/3"]
    var currentIndex : Int = 0
    var lessonTitle : String = "default"
    var lessonData = LessonData()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        let startingViewController: LessonPageViewController = viewControllerAtIndex(index: 0)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: true, completion: nil)
        pageViewController!.view.frame = CGRect(x: 0, y: 10, width: view.frame.size.width, height: view.frame.size.height);
        addChild(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
    
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! LessonPageViewController).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index: index)
    }
  
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! LessonPageViewController).pageIndex
        if index == NSNotFound {
            return nil
        }
    
        let answerChecked = (viewController as! LessonPageViewController).nextPageIsUnlocked
        progress += 1
        index += 1
        if (index == lessonData.pagesContents.count) || (!answerChecked) {
            return nil
        }
        return viewControllerAtIndex(index: index)
    }
  
    
    
    func viewControllerAtIndex(index: Int) -> LessonPageViewController?{
        if lessonData.pagesContents.count == 0 || index >= lessonData.pagesContents.count {
            return nil
        }
    
        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "SingleLessonViewController") as! LessonPageViewController
        pageContentViewController.titleText = lessonData.title
        pageContentViewController.pageIndex = index
        pageContentViewController.pagesNumber = lessonData.pagesContents.count
        pageContentViewController.pageContents = lessonData.pagesContents[index]
        
        currentIndex = index
    
        return pageContentViewController
    }
  
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.lessonData.pagesContents.count
    }
  
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
