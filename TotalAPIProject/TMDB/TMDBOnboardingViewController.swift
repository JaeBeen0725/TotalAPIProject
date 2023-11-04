//
//  TMDBOnboardingViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/25.
//

import UIKit
import SnapKit
import SwiftUI
import Kingfisher

class FirstViewController: UIViewController {
    
    let firstImageView = UIImageView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        firstPageSetting() 
    }
    
    func firstPageSetting() {
        
        view.addSubview(firstImageView)
        pageImageSetting(view: firstImageView, url: "https://img1.daumcdn.net/thumb/C300x430/?fname=https%3A%2F%2Ft1.daumcdn.net%2Fmovie%2Fbc8999d18f7d4bd8b579e6058b71e7c3d8890eb5")
      
    }
    
    
}

class SecondViewController: UIViewController {
    
    let secondImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        secondtPageSetting()
    }
    func secondtPageSetting() {
        view.addSubview(secondImageView)
        pageImageSetting(view: secondImageView, url: "https://img1.daumcdn.net/thumb/C300x430/?fname=https%3A%2F%2Ft1.daumcdn.net%2Fmovie%2Fce3dda655bc0eb73ffd6e82ba32e1bc6322b173a")
      
    
    }
    
}


class ThirdViewController: UIViewController {
    
    let thirdImageView = UIImageView()
    let startButton = {
        
        var view = UIButton()
        
        view.setTitle("시작", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
       return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        thirdtPageSetting()
        startButtonSetting()
    }
    
    func thirdtPageSetting() {
        
        view.addSubview(thirdImageView)
            pageImageSetting(view: thirdImageView, url: "https://i.namu.wiki/i/TO1C6AEmlikEX-A_lop6oyZMlFBzgHOS9yjyTVNknhvlAS_CgGsnRMxMZxpbbaRjkmZU5ygG4OtRUo2ZAI5f8w.webp")
          
        
        
        
    }
    
    
    func startButtonSetting() {
        print(#function)
        view.addSubview(startButton)
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        startButton.backgroundColor = .brown
        startButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.center.equalTo(view)
            
            UserDefaults.standard.set(true, forKey: "launch")
            
            
        }

    }
    
@objc func startButtonClicked() {
    print("===========+", #function)
    let sb = UIStoryboard(name: "Main", bundle: nil)
    
    guard let vc = sb.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {return}
    
    let nav = UINavigationController(rootViewController: vc)
    nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
   
    
    }
    
    
}


class TMDBOnboardingViewController: UIPageViewController {

    var list: [UIViewController] = []

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        view.backgroundColor = .lightGray
        
        delegate = self
        dataSource = self
        
        guard let first = list.first else {return}
        setViewControllers([first], direction: .forward, animated: true)
       
    }
    


}



extension TMDBOnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = list.firstIndex(of: viewController) else {return nil}
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = list.firstIndex(of: viewController) else {return nil}
        let nextindex = currentIndex + 1
        return nextindex >= list.count ? nil : list[nextindex]
        
    }
    
    
}
