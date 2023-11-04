//
//  WeatherManager.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/27.
//

import UIKit
import SwiftyJSON
import Alamofire

class WeatherManager {
    
    static let shared = WeatherManager()
    
    let url = "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=\(APIKey.weather)"
    
    func callRequestCodable(success: @escaping (WeatherData) -> Void, failure: @escaping () -> Void) {
        
        AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: WeatherData.self) { response in
            
            switch response.result {
                
            case .success(let value): success(value)
                
            case .failure(let error):
                print(error)
                failure()
                
                
            }
            
        }
        
        
    }
    
}



