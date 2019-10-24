//
//  SunriseSunsetModel.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/21/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import Foundation

struct SunriseSunsetModel: Decodable {
    var results: Results?
}

struct Results: Decodable {
    let sunrise: String?
    let sunset: String?
    var cityName: String?
    let solar_noon: String?
    let day_length: String?
    let civil_twilight_begin: String?
    let civil_twilight_end: String?
}
