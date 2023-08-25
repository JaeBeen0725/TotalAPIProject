//
//  TMDBOnboardingViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/25.
//

import UIKit
import SnapKit
class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
}

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
    }
}


class ThirdViewController: UIViewController {
    
    let startButton = {
        
        var view = UIButton()
        
        view.setTitle("시작", for: .normal)
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .black
        

       return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        startButtonSetting()
    }
    
    func startButtonSetting() {
        
        view.addSubview(startButton)
        startButton.addTarget(ViewController.self, action: #selector(<#T##@objc method#>), for: .touchUpInside)
        startButton.backgroundColor = .brown
        startButton.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.center.equalTo(view)
            
        }

    }
    
    @objc func startButtonClicked() {
        
        
        
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
