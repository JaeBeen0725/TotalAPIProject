//
//  ViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/17.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

struct Movie {
    let date: String
    let genre: Int
    let thumbnail: String
    let title: String
    let castId: Int
    let backImage: String
    let overView : String
}

class ViewController: UIViewController {
    @IBOutlet var movieTableView: UITableView!
    
    var movieList : [Movie] = []
    let genreList : [Int : String] = [28:"Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction", 10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        movieTableView.rowHeight = 400
        //movie()
        


        
        
    }
    
    
//    func movie() {
//        let url = "https://api.themoviedb.org/3/trending/all/week?api_key=\(APIKey.tmdbKey)"
//        AF.request(url, method: .get).validate().responseDecodable(of: TMDBData.self) { response in
//
//            guard let value = response.value else { return }
//            let date = Result.CodingKeys.rawValue(codingKey: "release_date")
//            print(date)
//
//        }
//        { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
                
                
                
//                for item in json["results"].arrayValue {
//                    let movieDate = item["release_date"].stringValue
//                    let movieGenre = item["genre_ids"][0].intValue
//                    let movieThumbnail = item["poster_path"].stringValue
//                    let movieTitle = item["title"].stringValue
//                    let movieCastId = item["id"].intValue
//                    let movieBackImage = item["backdrop_path"].stringValue
//                    let movieOverView = item["overview"].stringValue
//                    self.movieList.append(Movie(date: movieDate, genre: movieGenre, thumbnail: movieThumbnail, title: movieTitle, castId: movieCastId, backImage: movieBackImage, overView: movieOverView))
//                }
                
//                self.movieTableView.reloadData()
//
//                print("JSON: \(json)")
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.movieDateLabel.text = movieList[indexPath.row].date
        cell.movieGenreLabel.text = genreList[movieList[indexPath.row].genre]
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieList[indexPath.row].thumbnail)") {
            cell.movieImageView.kf.setImage(with: url)
        } else {
            print("이미지 없음")
        }
        
        cell.movieImageView.contentMode = .scaleAspectFill
        cell.movieTitleLabel.text = movieList[indexPath.row].title
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vc.id = movieList[indexPath.row].castId
        vc.titleText = movieList[indexPath.row].title
        vc.backgroundImagae = movieList[indexPath.row].backImage
        
        
        vc.textVieww = movieList[indexPath.row].overView
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



