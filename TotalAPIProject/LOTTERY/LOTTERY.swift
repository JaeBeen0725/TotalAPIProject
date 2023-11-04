//
//  LOTTERY.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/21.
//

import Foundation
import Alamofire


// MARK: - Lotto
struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

class LottoManager {
    static let shared = LottoManager()
    
    func callLotto(completionHandler: @escaping (Int, Int) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        
        AF.request(url, method: .get).validate().responseDecodable(of: Lotto.self) {
            response in
            guard let value = response.value else { return }
            print("responseData:", value)
            
            completionHandler(value.drwtNo4, value.drwtNo6)
        }
    }
    
}
