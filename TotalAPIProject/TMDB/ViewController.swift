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

//struct Movie {
//    let date: String
//    let genre: Int
//    let thumbnail: String
//    let title: String
//    let castId: Int
//    let backImage: String
//    let overView : String
//}

class ViewController: UIViewController {
    @IBOutlet var movieTableView: UITableView!
    
    var movieList : TMDBData = TMDBData(totalPages: 0, page: 0, totalResults: 0, results: [])
    let genreList : [Int : String] = [28:"Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction", 10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        movieTableView.rowHeight = 400
        //movie()
        
      callrequest()
        
    }
    
    func callrequest() {
        let url = "https://api.themoviedb.org/3/trending/all/week?api_key=\(APIKEY.tmdbKey)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: TMDBData.self) { response in
            
            guard let value = response.value else { return }
            
            self.movieList = value
            
                    self.movieTableView.reloadData()
            
        }
        
    }
    
    
    /*
    func movie() {
        let url = "https://api.themoviedb.org/3/trending/all/week?api_key=\(APIKey.tmdbKey)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json["results"].arrayValue {
                    let movieDate = item["release_date"].stringValue
                    let movieGenre = item["genre_ids"][0].intValue
                    let movieThumbnail = item["poster_path"].stringValue
                    let movieTitle = item["title"].stringValue
                    let movieCastId = item["id"].intValue
                    let movieBackImage = item["backdrop_path"].stringValue
                    let movieOverView = item["overview"].stringValue
                    self.movieList.append(Movie(date: movieDate, genre: movieGenre, thumbnail: movieThumbnail, title: movieTitle, castId: movieCastId, backImage: movieBackImage, overView: movieOverView))
                }
                
                self.movieTableView.reloadData()
                
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
    }
    */
    
}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        
        cell.movieDateLabel.text = movieList.results[indexPath.item].releaseDate
        cell.movieGenreLabel.text = genreList[movieList.results[indexPath.item].genreIDS[0]]
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movieList.results[indexPath.item].posterPath)") {
            cell.movieImageView.kf.setImage(with: url)
        } else {
            print("이미지 없음")
        }
        
        cell.movieImageView.contentMode = .scaleAspectFill
        cell.movieTitleLabel.text = movieList.results[indexPath.row].originalTitle
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vc.id = movieList.results[indexPath.row].id
        vc.titleText = movieList.results[indexPath.row].originalTitle ?? "타이틀 없음"
        vc.backgroundImagae = movieList.results[indexPath.row].backdropPath
        
        
        vc.textVieww = movieList.results[indexPath.row].overview
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}





