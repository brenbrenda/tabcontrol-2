//
//  testtViewController.swift
//  tabcontrol
//
//  Created by chia on 2020/3/9.
//  Copyright © 2020 chia. All rights reserved.
//

import UIKit
import Alamofire

class testtViewController: UIViewController {
     var jsonObj: [[String: String]]!
    var http = ""

    struct AQIData: Decodable {
        var result: Result
    }
    struct Result: Decodable {
        var records: [Record]
    }
    struct Record: Decodable{
        var SiteName: String
        var County: String
        var AQI: String
        var Status: String
        var CO: String
        var PM25 :String
        var PublishTime: String
    }

    @IBOutlet weak var Show: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        http = "http://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?filters=County eq '臺北市' and SiteName eq '士林'&fields=SiteName,County,AQI,Status,CO,PM2.5,PublishTime&sort=SiteName&offset=0&limit=100&sort=SiteId&format=json&token=5LgSf+2N1ECpYOcLk76OUA%22"
        //let url = http.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed
//        let url = http.removingPercentEncoding
        //let a1 = URL(string: url!)
        guard let url = http.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            else {
            // url 是 nil，沒辦法用
            // 這邊可以做一些例外處理
            return // 下面的行數不會被執行
            }
            // url 不是 nil，繼續使用 url
            //Show.text = url
            print(url)
            // 繼續使用 url!
            // let url = http.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            // let urlObj = URL(string: url)!*/
            // if let a2 = URL(string: http) {
            Alamofire.request(url).responseJSON(completionHandler:  {response in
            if response.result.isSuccess {
            
            if let result = response.value as? [String: AnyObject]{
            let dataList: [[String : Any]]? = result["result"]?["records"] as? [[String:Any]]
            print(dataList)
            for data in dataList! {
            print("location:\(data["SiteName"]!)")
            self.Show.text = data["AQI"] as? String
            print("AQI:\(data["AQI"]!)")
            //print("Staus:\(data["Staus"]!)")
            print("CO:\(data["CO"]!)")
            print("PM2.5:\(String(describing: data["PM2.5"]))")
            }
            }
            }else {
            print("error: \(response.error)")
            }
            }) != nil
        }
               
        /*Alamofire.request(.Get, "http://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?filters=County%20eq%20%27%E6%A1%83%E5%9C%92%E5%B8%82%27%20and%20SiteName%20eq%20%27%E6%A1%83%E5%9C%92%27&fields=SiteName,County,AQI,Status,CO,PM2.5,PublishTime&sort=SiteName&offset=0&limit=100&sort=SiteId&format=json&token=5LgSf+2N1ECpYOcLk76OUA%22").responseJOSN { (response) -> Void in
            if let Json = response.result.self {
                print(Json)
            }*/
        }
/*
   if let urlString = "http://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?filters=County%20eq%20%27%E6%A1%83%E5%9C%92%E5%B8%82%27%20and%20SiteName%20eq%20%27%E6%A1%83%E5%9C%92%27&fields=SiteName,County,AQI,Status,CO,PM2.5,PublishTime&sort=SiteName&offset=0&limit=100&sort=SiteId&format=json&token=5LgSf+2N1ECpYOcLk76OUA%22".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
           let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
              if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                 print(json)
         let root = try JSONDecoder().decode(Root.self, from: data)
                        for surah in root.data.surahs {
                            print(surah.number, surah.name, surah.englishName)
                        }
              }
           }
           task.resume()
        
        }*/
        // Do any additional setup after loading the view.
        /*let url = URL(string:  "http://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?filters=County%20eq%20%27%E6%A1%83%E5%9C%92%E5%B8%82%27%20and%20SiteName%20eq%20%27%E6%A1%83%E5%9C%92%27&fields=SiteName,County,AQI,Status,CO,PM2.5,PublishTime&sort=SiteName&offset=0&limit=100&sort=SiteId&format=json&token=5LgSf+2N1ECpYOcLk76OUA%22")
        URLSession.shared.dataTask(with: url!) { data, _, _ in
            if let data = data {
                let users = try? JSONDecoder().decode(AQIData.self, from: data)
                print(users)
                //Show.text = users?[0].result.SiteName
                   }
        }.resume()*/
        /*let url = URL(string:  "http://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?filters=County%20eq%20%27%E6%A1%83%E5%9C%92%E5%B8%82%27%20and%20SiteName%20eq%20%27%E6%A1%83%E5%9C%92%27&fields=SiteName,County,AQI,Status,CO,PM2.5,PublishTime&sort=SiteName&offset=0&limit=100&sort=SiteId&format=json&token=5LgSf+2N1ECpYOcLk76OUA%22")

               let data = try! Data(contentsOf: url!)

               jsonObj = try! JSONSerialization.jsonObject(with: data,

                      options: .allowFragments) as! [[String: String]]

               for p in jsonObj{

                   print("Place:\(p["SiteName"]!)")

                   print("AQI:\(p["AQI"]!)")

                   Show.text = (p["SiteName"]!) + (p["AQI"]!)

                   //Sitw.text = (p["SiteName"]!) + (p["AQI"]!)

               }
*/
       
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



