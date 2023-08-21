//
//  DetailKoficViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/19.
//

import UIKit
import SwiftyJSON
import Alamofire





class DetailKoficViewController: UIViewController {
    
    var koficNum = 1
    var koficTitle: String = "a"
    var detailList: [String] = []
    @IBOutlet var detailKoficTableView: UITableView!
    @IBOutlet var detailTitleLabel: UILabel!
    @IBOutlet var detailGenreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("=================\(koficNum)")
        detailKoficTableView.dataSource = self
        detailKoficTableView.delegate = self
        detailKofic(movieCd: koficNum)
        detailTitleLabel.text = koficTitle
    }
    
    
    func detailKofic(movieCd: Int) {
        
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(APIKey.kofic)&movieCd=\(movieCd)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
            

                for item in json["movieInfoResult"]["movieInfo"]["actors"].arrayValue {


                    let actor = item["peopleNm"].stringValue


                    self.detailList.append(actor)
                }
                
                self.detailKoficTableView.reloadData()
                
                
                 print("JSON: \(json)")
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
        
        cell.actorName.text = detailList[indexPath.row]
        
        return cell
    }
    
}


