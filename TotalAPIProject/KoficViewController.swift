//
//  KoficViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/19.
//

import UIKit
import SwiftyJSON
import Alamofire



struct DailyBoxOffice {
    let movieCd: Int
    let movieName: String
    let openDT: String
    let rank: String
}

struct WeeklyBoxOffice {
    let movieCd: Int
    let movieName: String
    let openDT: String
    let rank: String
}
let dw = ["searchDailyBoxOfficeList.json", "searchWeeklyBoxOfficeList.json"]

class KoficViewController: UIViewController {
    
    @IBOutlet var dailyBoxOfficeCollectionView: UICollectionView!
    @IBOutlet var weeklyBoxOfficeTalbleView: UITableView!
    
    var dalilBoxOfficeList: [DailyBoxOffice] = []
    var weeklyBoxOfficeList: [WeeklyBoxOffice] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyBoxOfficeCollectionView.dataSource = self
        dailyBoxOfficeCollectionView.delegate = self
        weeklyBoxOfficeTalbleView.dataSource = self
        weeklyBoxOfficeTalbleView.delegate = self
        
        koficAPI(targetDt: "20220101")
        collectionViewLayout()
        weeklyBoxOfficeTalbleView.rowHeight = 100
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (spacing * 2)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .horizontal
        dailyBoxOfficeCollectionView.collectionViewLayout = layout
        
        
    }
    
    
    
    
    func koficAPI(targetDt: String) {
        
        for i in 0...1 {
            if i == 0 {
                let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.kofic)&targetDt=\(targetDt)"
                AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                            let movieCd = item["movieCd"].intValue
                            let movieName = item["movieNm"].stringValue
                            let openDt = item["openDt"].stringValue
                            let rank = item["rank"].stringValue
                            
                            self.dalilBoxOfficeList.append(DailyBoxOffice(movieCd: movieCd, movieName: movieName, openDT: openDt, rank: rank))
                            
                            
                        }
                        
                        
                        self.dailyBoxOfficeCollectionView.reloadData()
                        print("daily: \(self.dalilBoxOfficeList)")
                        
                        // print("JSON: \(json)")
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
            else {
                let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=\(APIKey.kofic)&targetDt=\(targetDt)"
                AF.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        for item in json["boxOfficeResult"]["weeklyBoxOfficeList"].arrayValue {
                            let movieCd = item["movieCd"].intValue
                            let movieName = item["movieNm"].stringValue
                            let openDt = item["openDt"].stringValue
                            let rank = item["rank"].stringValue
                            
                            
                            
                            self.weeklyBoxOfficeList.append(WeeklyBoxOffice(movieCd: movieCd, movieName: movieName, openDT: openDt, rank: rank))
                        }
                        
                        
                        
                        self.weeklyBoxOfficeTalbleView.reloadData()
                        print("weekly: \(self.weeklyBoxOfficeList)")
                        
                        
                        // print("JSON: \(json)")
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
        
        
        
    }
    
    
    
    
}


extension KoficViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyBoxOfficeList.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "KoficTableViewCell", for: indexPath) as? KoficTableViewCell else {return UITableViewCell() }
        
        cell.weeklyBoxOfficeRankLabel.text = "\(weeklyBoxOfficeList[indexPath.row].rank)위!"
        cell.weeklyBoxOfficeTitleLabel.text = weeklyBoxOfficeList[indexPath.row].movieName
        cell.weeklyBoxOfficedateLabel.text = weeklyBoxOfficeList[indexPath.row].openDT
        
        
        
        return cell
    }
    
    
    
}



extension KoficViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dalilBoxOfficeList.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KoficCollectionViewCell", for: indexPath) as? KoficCollectionViewCell else {return UICollectionViewCell() }
        
        cell.dailyBoxOfficeRankLAbel.text = "\(dalilBoxOfficeList[indexPath.row].rank)위!!"
        cell.dailtBoxOfficeTitleLabel.text = dalilBoxOfficeList[indexPath.row].movieName
        cell.dailyBoxOfficeDateLabel.text = dalilBoxOfficeList[indexPath.row].openDT
        
        return cell
    }
    
    
    
}


