//
//  SunriseSunsetModel.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/21/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import Foundation

struct SunriseSunsetModel: Decodable {
    let results: Results?
}

struct Results: Decodable {
    let sunrise: String?
    let sunset: String?
}
