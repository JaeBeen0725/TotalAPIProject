//
//  DetailViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Cast {
    let castTumbnail: String
    let castName: String
    let charactorName: String
}

class DetailViewController: UIViewController {
    @IBOutlet var moviebackGroundImageView: UIImageView!
    @IBOutlet var movieTextView: UITextView!
    
    @IBOutlet var castTableView: UITableView!
    
    var titleText: String = ""
    var id = 1
    var backgroundImagae = ""
    var textVieww = ""
    var castList: [Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        castTableView.dataSource = self
        castTableView.delegate = self
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(backgroundImagae)")
        moviebackGroundImageView.kf.setImage(with: url)
        
        movieTextView.text = textVieww
        self.title = titleText
        detail(id: id)
        castTableView.rowHeight = 200
    }
    
    func detail(id: Int) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json["cast"].arrayValue{
                    let tumbnail = item["profile_path"].stringValue
                    let name = item["name"].stringValue
                    let charactorName = item["character"].stringValue
                    self.castList.append(Cast(castTumbnail: tumbnail, castName: name, charactorName: charactorName))
                    
                }
                
              
                
                self.castTableView.reloadData()
                print("JSON: \(json)")
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}



extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell") as? CastTableViewCell else {return UITableViewCell() }
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(castList[indexPath.row].castTumbnail)")
        cell.actorImageView.kf.setImage(with: url)
        
        cell.actorNameLabel.text = castList[indexPath.row].castName
        cell.characterNameLabel.text = castList[indexPath.row].charactorName
        
        return cell
    }
}
