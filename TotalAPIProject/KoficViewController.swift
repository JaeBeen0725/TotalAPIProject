//
//  KoficViewController.swift
//  TotalAPIProject
//
//  Created by Jae Oh on 2023/08/19.
//

import UIKit
import SwiftyJSON
import Alamofire



//struct DailyBoxOffice {
//    let movieCd: Int
//    let movieName: String
//    let openDT: String
//    let rank: String
//}
//
//struct WeeklyBoxOffice {
//    let movieCd: Int
//    let movieName: String
//    let openDT: String
//    let rank: String
//}


class KoficViewController: UIViewController {
    
    @IBOutlet var dailyBoxOfficeCollectionView: UICollectionView!
    @IBOutlet var weeklyBoxOfficeTalbleView: UITableView!
    
    var dalilBoxOfficeList: Kofic = Kofic(boxOfficeResult: BoxOfficeResult(boxofficeType: "", showRange: "", dailyBoxOfficeList: []))
    
    var weeklyBoxOfficeList: WeekKofic = WeekKofic(boxOfficeResult: WeeklyBoxOfficeResult(boxofficeType: "", showRange: "", yearWeekTime: "", weeklyBoxOfficeList: []))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyBoxOfficeCollectionView.dataSource = self
        dailyBoxOfficeCollectionView.delegate = self
        weeklyBoxOfficeTalbleView.dataSource = self
        weeklyBoxOfficeTalbleView.delegate = self
        
        koficAPI(targetDt: 20210725)
        weekKofic(targetDt: 20210725)
        
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
    
    

    func koficAPI(targetDt: Int) {
        print(#function)
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.kofic)&targetDt=\(targetDt)"
        AF.request(url, method: .get).validate().responseDecodable(of: Kofic.self) { response in
            //                print(response.result)
            //                print(response)
            // dump(response)
            
            guard let value = response.value else { return }
            // dump(value)
            self.dalilBoxOfficeList = value
            
            self.dailyBoxOfficeCollectionView.reloadData()
            // print(self.dalilBoxOfficeList)
            /*
             switch response.result {
             
             
             
             case .success(let value):
             let json = JSON(value)
             print(json)
             for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
             let movieCd = item["movieCd"].intValue
             let movieName = item["movieNm"].stringValue
             let openDt = item["openDt"].stringValue
             let rank = item["rank"].stringValue
             
             self.dalilBoxOfficeList.append(DailyBoxOffice(movieCd: movieCd, movieName: movieName, openDT: openDt, rank: rank))
             
             
             }
             
             
             self.dailyBoxOfficeCollectionView.reloadData()
             //  print("daily: \(self.dalilBoxOfficeList)")
             
             // print("JSON: \(json)")
             case .failure(let error):
             print(error)
             }
             
             }
             */
        }
    }
    func weekKofic(targetDt: Int) {
                let url1 = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=\(APIKey.kofic)&targetDt=\(targetDt)"
                AF.request(url1, method: .get).validate().responseDecodable(of: WeekKofic.self) { response in

                    guard let value = response.value else { return }
                  //  print("weeeeeekk", value)
                    self.weeklyBoxOfficeList = value
                    self.weeklyBoxOfficeTalbleView.reloadData()
                    
                    print(self.weeklyBoxOfficeList)
                    /*
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
                     // print("weekly: \(self.weeklyBoxOfficeList)")


                     // print("JSON: \(json)")
                     case .failure(let error):
                     print(error)
                     }
                     }
                     */



        }

    }
    
}

    extension KoficViewController: UITableViewDataSource,UITableViewDelegate {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return weeklyBoxOfficeList.boxOfficeResult.weeklyBoxOfficeList!         .count
        }




        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "KoficTableViewCell", for: indexPath) as? KoficTableViewCell else {return UITableViewCell() }

            let week = weeklyBoxOfficeList.boxOfficeResult.weeklyBoxOfficeList![indexPath.row]
            cell.weeklyBoxOfficeRankLabel.text = "\(week.rank)위!"
            cell.weeklyBoxOfficeTitleLabel.text = week.movieNm
            cell.weeklyBoxOfficedateLabel.text = week.openDt

            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailKoficViewController") as? DetailKoficViewController else { return }
            let week = weeklyBoxOfficeList.boxOfficeResult.weeklyBoxOfficeList![indexPath.row]
            
            vc.koficTitle = week.movieNm
            vc.koficNum = week.movieCD

            self.navigationController?.pushViewController(vc, animated: true)
        }



    }

    
    
    extension KoficViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dalilBoxOfficeList.boxOfficeResult.dailyBoxOfficeList!.count
        }
        
        
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KoficCollectionViewCell", for: indexPath) as? KoficCollectionViewCell else {return UICollectionViewCell() }
            
            let daily = dalilBoxOfficeList.boxOfficeResult.dailyBoxOfficeList![indexPath.row]
            cell.dailyBoxOfficeRankLAbel.text = "\(daily.rank)위!!"
            cell.dailtBoxOfficeTitleLabel.text = daily.movieNm
            cell.dailyBoxOfficeDateLabel.text = daily.openDt
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let vc = self.storyboard?.instantiateViewController(identifier: "DetailKoficViewController") as? DetailKoficViewController else {return}
            
            let daily = dalilBoxOfficeList.boxOfficeResult.dailyBoxOfficeList![indexPath.row]
            
            vc.koficNum = daily.movieCD
            vc.koficTitle = daily.movieNm
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    
    
    

