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
    
    var koficNum: String = ""
    var koficTitle: String = "a"
    var detailList: DetailKofic = DetailKofic(movieInfoResult: MovieInfoResult(movieInfo: MovieInfo(movieCD: "", movieNm: "", movieNmEn: "", movieNmOg: "", showTm: "", prdtYear: "", openDt: "", prdtStatNm: "", actors: []), source: ""))
    @IBOutlet var detailKoficTableView: UITableView!
    @IBOutlet var detailTitleLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("=================\(koficNum)")
        detailKoficTableView.dataSource = self
        detailKoficTableView.delegate = self
        detailKofic(movieCd: koficNum)
        detailTitleLabel.text = koficTitle
    }
    
    
    func detailKofic(movieCd: String) {
        
        let url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(APIKEY.kofic)&movieCd=\(movieCd)"
        AF.request(url, method: .get).validate().responseDecodable(of: DetailKofic.self) { response in
            
            guard let value = response.value else { return }
            
            self.detailList = value
            self.detailKoficTableView.reloadData()
        }
        
        
    }
    
    
}
    extension DetailKoficViewController: UITableViewDataSource,UITableViewDelegate {
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return detailList.movieInfoResult.movieInfo.actors.count
        }
        
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailKoficTableViewCell", for: indexPath) as? DetailKoficTableViewCell else {return UITableViewCell() }
            
            cell.actorName.text = detailList.movieInfoResult.movieInfo.actors[indexPath.row].peopleNmEn
            
            return cell
        }
        
    }
    
    

