//
//  WeatherViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/27.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {

    let templabel = {
        let view = UILabel()
        view.backgroundColor = .black
        view.textColor = .white
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        
      
       return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        wheatherLabelLayoutSetting()
        
        wheatherCompletionHandling()
      
    }
    
    func wheatherLabelLayoutSetting() {
        
        view.addSubview(templabel)
        templabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.center.equalToSuperview()
            make.leftMargin.greaterThanOrEqualToSuperview()
            make.trailingMargin.lessThanOrEqualToSuperview()
        }
        
    }
    
    
    func wheatherCompletionHandling() {
        
        WeatherManager.shared.callRequestCodable { data in
            self.templabel.text = "현재 온도는 \(data.main.temp - 273.15)도 입니다."
        } failure: {
            print("Alert띄우기")
        }

        
    }
    
    
    

    

}
