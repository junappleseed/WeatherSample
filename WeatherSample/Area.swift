//
//  Area.swift
//  WeatherSample
//
//  Created by Jun on 2015/10/17.
//  Copyright © 2015年 junappleseed. All rights reserved.
//

import Foundation

class Area {
    static let items: [Area] = [
        Area(areaName: "北海道地方", cityId: "016010"), // 札幌
        Area(areaName: "東北地方", cityId: "040010"), // 仙台
        Area(areaName: "関東地方", cityId: "130010"), // 東京
        Area(areaName: "北信越地方", cityId: "150010"), // 新潟
        Area(areaName: "東海地方", cityId: "230010"), // 名古屋
        Area(areaName: "近畿地方", cityId: "270000"), // 大阪
        Area(areaName: "中国地方", cityId: "340010"), // 広島
        Area(areaName: "四国地方", cityId: "380010"), // 松山
        Area(areaName: "九州地方", cityId: "400010"), // 福岡
        Area(areaName: "沖縄地方", cityId: "471010") // 那覇
    ]
    
    /* 画面表示用の地方名 */
    let areaName: String!
    /* 1次細分区のID */
    let cityId: String!
    
    private init(areaName: String, cityId: String) {
        self.areaName = areaName
        self.cityId = cityId
    }
}