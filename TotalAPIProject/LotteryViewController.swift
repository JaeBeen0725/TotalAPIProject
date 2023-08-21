//
//  LotteryViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/21.
//

import UIKit
import Alamofire



class LotteryViewController: UIViewController {

    @IBOutlet var lottoResult: UILabel!
  

    override func viewDidLoad() {
        super.viewDidLoad()

      callRequest(number: 1080)
    }
    
    func callRequest(number: Int) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        AF.request(url, method: .get).validate().responseDecodable(of: Lotto.self) {
            response in
            
            guard let value = response.value else { return }
            
            self.lottoResult.text = "\(value.drwNoDate) + \(value.drwNo)"
        }
    }
 
    
    

}
