//
//  TMDBGenericExtension.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/26.
//

import UIKit
import Kingfisher
import SnapKit
extension UIViewController {
    
    func pageImageSetting<T: UIImageView>(view: T, url: String){
        let url = URL(string: url)
        view.kf.setImage(with: url)
        view.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        
        
    }
}
