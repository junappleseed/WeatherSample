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
        Area(id: "1", name: "北海道", city: "016010"), // 札幌
        Area(id: "2", name: "東北", city: "040010"), // 仙台
        Area(id: "3", name: "関東", city: "130010"), // 東京
        Area(id: "4", name: "北信越", city: "150010"), // 新潟
        Area(id: "5", name: "東海", city: "230010"), // 名古屋
        Area(id: "6", name: "近畿", city: "270000"), // 大阪
        Area(id: "7", name: "中国", city: "340010"), // 広島
        Area(id: "8", name: "四国", city: "380010"), // 松山
        Area(id: "9", name: "九州", city: "400010"), // 福岡
        Area(id: "10", name: "沖縄", city: "471010") // 那覇
    ]
    
    let id: String!
    let name: String!
    let city: String!
    
    private init(id: String, name: String, city: String) {
        self.id = id
        self.name = name
        self.city = city
    }
}