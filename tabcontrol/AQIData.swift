//
//  File.swift
//  tabcontrol
//
//  Created by chia on 2020/3/8.
//  Copyright © 2020 chia. All rights reserved.
//

import Foundation

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

