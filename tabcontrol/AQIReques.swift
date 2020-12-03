//
//  AQIReques.swift
//  tabcontrol
//
//  Created by chia on 2020/3/9.
//  Copyright © 2020 chia. All rights reserved.
//

import Foundation

enum AQIRequesError:Error {
    case noDataAvailable
    case canNotProcessData
}

/*struct AQIReques {
    let resourceURL:URL
    
    init(city1:String, city2:String) {
        let resourceString = "http://opendata.epa.gov.tw/webapi/api/rest/datastore/355000000I-000259?filters=SiteName eq '=\(city2)' and County eq '=\(city1) '&fields=SiteName,County,AQI,Status,CO,PM2.5,PublishTime&sort=SiteName&offset=0&limit=100&sort=SiteId&format=json&token=5LgSf+2N1ECpYOcLk76OUA%22"
        guard let resourceUrl = URL(string: resourceString) else {fatalError()}
        
    }
    func getAQI (completion: @escaping(Result)-> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                print("npt")
                return
            }
            do{
                let decoder = JSONDecoder()
                let AQIresponse = try decoder.decode(AQIData.self, from: jsonData)
                
            }catch{
                print("faile2")
            }
        }
    }
}*/
