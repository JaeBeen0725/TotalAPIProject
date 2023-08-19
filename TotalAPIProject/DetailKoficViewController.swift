//
//  DetailKoficViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/19.
//

import UIKit
import SwiftyJSON
import Alamofire




let koficNum = 1
class DetailKoficViewController: UIViewController {
    
    var detailList: [Detail] = []
    @IBOutlet var detailKoficTableView: UITableView!
    @IBOutlet var detailTitleLabel: UILabel!
    @IBOutlet var detailDateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailKoficTableView.dataSource = self
        detailKoficTableView.delegate = self
        
    }
    
    
    func detailKofic(movieCd: String) {
        
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(APIKey.kofic)&movieCd=\(movieCd)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                
                for item in json["movieInfoResult"]["movieInfo"].arrayValue {
                    let movieNm = item["movieNm"].stringValue
                    let genre = item["genres"][0].stringValue
                    let actor = item["actors"]["peopleNm"].stringValue
                    
                }
                
                self.detailKoficTableView.reloadData()
                
                
                // print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}



extension DetailKoficViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailKoficTableViewCell", for: indexPath) as? DetailKoficTableViewCell else {return UITableViewCell() }
        
        
        
        return cell
    }
    
}
