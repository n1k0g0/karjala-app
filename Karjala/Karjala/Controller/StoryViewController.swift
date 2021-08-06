//
//  StoryPageViewController.swift
//  SanatVersion2
//
//  Created by Николай Горбачев on 04.05.2021.
//

import UIKit

class StoryViewController: UIPageViewController, UIPageViewControllerDataSource {
    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["1/3", "2/3", "3/3"]
    var currentIndex : Int = 0
    var storyTitle = "default"
    var storyData = LessonData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        let startingViewController: StoryPageViewController = viewControllerAtIndex(index: 0)!
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
        var index = (viewController as! StoryPageViewController).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index: index)
    }
  
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! StoryPageViewController).pageIndex
    
        if index == NSNotFound {
            return nil
        }
    
        index += 1
    
        if (index == storyData.pagesContents.count) {
            return nil
        }
    
        return viewControllerAtIndex(index: index)
    }
  
    func viewControllerAtIndex(index: Int) -> StoryPageViewController? {
        if storyData.pagesContents.count == 0 || index >= storyData.pagesContents.count {
            return nil
        }
    
        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "SingleStoryViewController") as! StoryPageViewController
        pageContentViewController.titleText = storyData.title
        pageContentViewController.pageIndex = index
        pageContentViewController.pagesNumber = storyData.pagesContents.count
        pageContentViewController.pageContents = storyData.pagesContents[index]
    
        currentIndex = index
        return pageContentViewController
    }
  
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return storyData.pagesContents.count
    }
  
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
  
}
