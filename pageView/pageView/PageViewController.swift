//
//  PageViewController.swift
//  pageView
//
//  Created by Admin on 21/01/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    let presentScreenContent = [
        "Первая страница презентации, расказывающая о том, что наше приложение из себя представляет",
        "Вторая страница презентации, рассказывает о какой-то удобной фишке приложения",
        "Третья страница презентации тоже рассказывает о чем-то очень интересном",
        "Ну и наконец последняя страница презентации с напутствием в добрый путь=)",
        ""
    ]
    
    let emojiArray = ["🙃", "🤓", "🤩", "🖖", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        if let contentViewController = showViewControllerAtIndex(0){
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
        
        
    }
    func showViewControllerAtIndex(_ index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil }
        guard index < presentScreenContent.count else {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey:"presentationWasViewed")
            dismiss(animated: true, completion: nil)
            return nil }
        guard let contentViewController = storyboard?.instantiateViewController(
            withIdentifier: "ContentViewController") as? ContentViewController else { return nil }

        contentViewController.presentText = presentScreenContent[index]
        contentViewController.emoji = emojiArray[index]
        contentViewController.curentPage = index
        contentViewController.numberOfPages = presentScreenContent.count
        
        return contentViewController

    }
}

extension PageViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).curentPage
        pageNumber -= 1
        
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! ContentViewController).curentPage
        pageNumber += 1
        
        return showViewControllerAtIndex(pageNumber)
    }
    
    
}
