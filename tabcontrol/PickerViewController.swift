//
//  PickerViewController.swift
//  tabcontrol
//
//  Created by chia on 2020/3/7.
//  Copyright © 2020 chia. All rights reserved.
//

import UIKit
import Alamofire
/*
extension URL{
    
    static func initPercent(string:String) -> URL
    {
        let urlwithPercentEscapes = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let url = URL.init(string: urlwithPercentEscapes!)
        return url!
    }
}*/
class Country {
    var country: String
    var cities: [String]
    init(country:String, cities:[String]) {
        self.cities = cities
        self.country = country
    }
}

class PickerViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var Site: UILabel!
    @IBOutlet weak var county: UILabel!
    @IBOutlet weak var aqi: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var co: UILabel!
    @IBOutlet weak var pm25: UILabel!
    @IBOutlet weak var publishtime: UILabel!
    
    @IBOutlet weak var PickCity: UIPickerView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var region: UILabel!
    
    var countries = [Country]()
   
    //aqi
    
    var ShowDatatxt = "message"
    var country = ""
    var city1 = ""
    var SiteName:String!
    var County: String!
    var AQI: String!
    var Status: String!
    var CO: String!
    var PM25: String!
    var PublishTime: String!
    var http = ""
    //bvar StatustoCOLOR:
    var AQItoINT: Int = 0
    var thebestvo = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 2
       }
      
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           if component == 0{
               return countries.count
           }else{
               let selectedCountry = pickerView.selectedRow(inComponent: 0)
               return countries[selectedCountry].cities.count
           }
       }
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
              if component == 0 {
                  return countries[row].country
              }else{
                  let selectedCountry = pickerView.selectedRow(inComponent: 0)
                  return countries[selectedCountry].cities[row]
           }
              
       }
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           pickerView.reloadComponent(1)
           let selectedCountry = pickerView.selectedRow(inComponent: 0)
           let selectedCity = pickerView.selectedRow(inComponent: 1)
           country = countries[selectedCountry].country as String
           if city1 != countries[selectedCountry].cities[selectedCity]
           {
               city1 = countries[selectedCountry].cities[selectedCity] as String
               getAQIdata(city1: country, city2: city1)
           }
           else{
               city1 = countries[selectedCountry].cities[selectedCity] as String
               getAQIdata(city1: country, city2: city1)
           }
           
           //county.text = country
           //Site.text = city1
           
       }
       func getAQIdata(city1:String, city2:String){
           http = "https://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?filters=County eq '"+city1+"' and SiteName eq '"+city2+"'&fields=SiteName,County,AQI,Status,CO,PM2.5,PublishTime&sort=SiteName&offset=0&limit=100&sort=SiteId&format=json&token=5LgSf+2N1ECpYOcLk76OUA%22"
                   //let url = http.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed
           //        let url = http.removingPercentEncoding
                   //let a1 = URL(string: url!)
               guard let url = http.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                   else {
                       // url 是 nil，沒辦法用
                       // 這邊可以做一些例外處理
                       let alert = UIAlertController(title: "注意", message: "請重新選擇", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "我知道了", style: .default, handler: nil))
                       present(alert, animated: true)
                   return // 下面的行數不會被執行
                   }
           
           Alamofire.request(url).responseJSON(completionHandler:  {response in
               if response.result.isSuccess {
                  
                   if let result = response.value as? [String: AnyObject]{
                       let dataList: [[String : Any]] = result["result"]?["records"] as! [[String:Any]]
                       for data in dataList {
                           //print("location:\(["SiteName"])")
                           self.County = data["County"] as? String
                           self.SiteName = data["SiteName"] as? String
                           self.AQI = data["AQI"] as? String
                           self.CO = data["CO"] as? String
                           self.PM25 = data["PM2.5"] as? String
                           self.PublishTime = data["PublishTime"] as? String
                           self.Status = data["Status"] as? String
                           //bvar StatustoCOLOR:
                           //self.AQItoINT = data["AQI"] as! Int
                           self.county.text = "縣市:"+self.County
                           self.Site.text = "測站:"+self.SiteName
                           self.aqi.text = "AQI指數:"+self.AQI
                           self.status.text = "空氣品質指標:"+self.Status
                           self.co.text = "CO:"+self.CO
                           self.pm25.text = "PM2.5:"+self.PM25
                           self.publishtime.text = "測量時間"+self.PublishTime
                           self.AQItoINT = Int(self.AQI)!
                           if self.AQItoINT < 50{
                               self.aqi.backgroundColor = UIColor.green
                               self.status.backgroundColor = UIColor.green
                           }
                           else if self.AQItoINT > 50 && self.AQItoINT <= 100{
                               self.aqi.backgroundColor = UIColor.yellow
                               self.status.backgroundColor = UIColor.yellow
                           }
                           else if self.AQItoINT > 100 && self.AQItoINT <= 150{
                               self.aqi.backgroundColor = UIColor.orange
                               self.status.backgroundColor = UIColor.orange
                           }
                           else if self.AQItoINT > 150 && self.AQItoINT <= 200{
                               self.aqi.backgroundColor = UIColor.red
                               self.status.backgroundColor = UIColor.red
                           }
                           else if self.AQItoINT > 200 && self.AQItoINT <= 300{
                               self.aqi.backgroundColor = UIColor.purple
                               self.status.backgroundColor = UIColor.purple
                           }
                           else if self.AQItoINT > 300 && self.AQItoINT <= 500{
                               self.aqi.backgroundColor = self.thebestvo
                               self.status.backgroundColor = self.thebestvo
                           }
                       }
                   }
               }else {
                   print("error")
               }
           })
           //compare with value -> color
           /*guard AQItoINT != nil
           else{
               let alert = UIAlertController(title: "注意", message: "請重新選擇", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "我知道了", style: .default, handler: nil))
                                  present(alert, animated: true)
           }*/
           
           
       }



    override func viewDidLoad() {
           super.viewDidLoad()
        /*county.text = "縣市:"
        Site.text = "測站:"
        aqi.text = "AQI指數:"
        status.text = "空氣品質指標:"
        co.text = "CO:"
        pm25.text = "PM2.5:"
        publishtime.text = "測量時間"*/

        PickCity.delegate = self
        PickCity.dataSource = self
        countries.append(Country(country: "臺北市", cities: ["士林","大同","中山","古亭","松山","陽明","萬華"]))
        countries.append(Country(country: "新北市", cities: ["三重","土城","永和","汐止","板橋","林口","淡水","富貴角","菜寮","新北(樹林)","新店","新莊","萬里"]))
        countries.append(Country(country: "桃園市", cities: ["大園","中壢","平鎮","桃園","桃園(觀音工業區)","龍潭","觀音"]))
        countries.append(Country(country: "新竹縣", cities: ["竹東","湖口"]))
        countries.append(Country(country: "新竹市", cities: ["新竹"]))
        countries.append(Country(country: "苗栗縣", cities: ["三義","苗栗","頭份"]))
        countries.append(Country(country: "台中市", cities: ["大里","西屯","沙鹿","忠明","豐原"]))
        countries.append(Country(country: "彰化縣", cities: ["二林","彰化","彰化(大城)","線西"]))
        countries.append(Country(country: "雲林縣", cities: ["斗六","崙背","麥寮","臺西"]))
        countries.append(Country(country: "嘉義縣", cities: ["朴子","新港"]))
        countries.append(Country(country: "嘉義市", cities: ["嘉義"]))
        countries.append(Country(country: "臺南市", cities: ["安南","善化","新營","臺南","臺南(麻豆)"]))
        countries.append(Country(country: "高雄市", cities: ["大寮","小港","仁武","左營","林園","前金","前鎮","美濃","高雄(左營)","高雄(楠梓)","復興","楠梓","鳳山","橋頭"]))
        countries.append(Country(country: "屏東縣", cities: ["屏東","屏東(琉球)","恆春","潮州"]))
        countries.append(Country(country: "南投縣", cities: ["竹山","南投","埔里"]))
        countries.append(Country(country: "基隆市", cities: ["基隆"]))
        countries.append(Country(country: "宜蘭縣", cities: ["東山","宜蘭"]))
        countries.append(Country(country: "花蓮縣", cities: ["花蓮"]))
        countries.append(Country(country: "台東縣", cities: ["台東","關山"]))
        countries.append(Country(country: "澎湖縣", cities: ["馬公"]))
        countries.append(Country(country: "連江縣", cities: ["馬祖"]))
        countries.append(Country(country: "金門縣", cities: ["金門"]))
        http = "http://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?filters=County%20eq%20%27%E8%87%BA%E5%8C%97%E5%B8%82%27%20and%20SiteName%20eq%20%27%E5%A3%AB%E6%9E%97%27&fields=SiteName,County,AQI,Status,CO,PM2.5,PublishTime&sort=SiteName&offset=0&limit=100&sort=SiteId&format=json&token=5LgSf+2N1ECpYOcLk76OUA%22"
        
        Alamofire.request(http).responseJSON(completionHandler:  {response in
        if response.result.isSuccess {
           
            if let result = response.value as? [String: AnyObject]{
                let dataList: [[String : Any]] = result["result"]?["records"] as! [[String:Any]]
                for data in dataList {
                    //print("location:\(["SiteName"])")
                    self.County = data["County"] as? String
                    self.SiteName = data["SiteName"] as? String
                    self.AQI = data["AQI"] as? String
                    self.CO = data["CO"] as? String
                    self.PM25 = data["PM2.5"] as? String
                    self.PublishTime = data["PublishTime"] as? String
                    self.Status = data["Status"] as? String
                    //bvar StatustoCOLOR:
                    //self.AQItoINT = data["AQI"] as! Int
                    self.county.text = "縣市:"+self.County
                    self.Site.text = "測站:"+self.SiteName
                    self.aqi.text = "AQI指數:"+self.AQI
                    self.status.text = "空氣品質指標:"+self.Status
                    self.co.text = "CO:"+self.CO
                    self.pm25.text = "PM2.5:"+self.PM25
                    self.publishtime.text = "測量時間"+self.PublishTime
                    self.AQItoINT = Int(self.AQI)!
                    if self.AQItoINT < 50{
                        self.aqi.backgroundColor = UIColor.green
                        self.status.backgroundColor = UIColor.green
                    }
                    else if self.AQItoINT > 50 && self.AQItoINT <= 100{
                        self.aqi.backgroundColor = UIColor.yellow
                        self.status.backgroundColor = UIColor.yellow
                    }
                    else if self.AQItoINT > 100 && self.AQItoINT <= 150{
                        self.aqi.backgroundColor = UIColor.orange
                        self.status.backgroundColor = UIColor.orange
                    }
                    else if self.AQItoINT > 150 && self.AQItoINT <= 200{
                        self.aqi.backgroundColor = UIColor.red
                        self.status.backgroundColor = UIColor.red
                    }
                    else if self.AQItoINT > 200 && self.AQItoINT <= 300{
                        self.aqi.backgroundColor = UIColor.purple
                        self.status.backgroundColor = UIColor.purple
                    }
                    else if self.AQItoINT > 300 && self.AQItoINT <= 500{
                        self.aqi.backgroundColor = self.thebestvo
                        self.status.backgroundColor = self.thebestvo
                    }
                }
            }
       }
    })
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

}
