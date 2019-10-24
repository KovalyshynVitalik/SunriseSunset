//
//  GooglePlaceModel.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/24/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import Foundation
import CoreLocation

class GooglePlaceModel {
    var cityName: String
    var cityCoordinates:  CLLocationCoordinate2D
    
    init(cityName:String,cityCoordinates: CLLocationCoordinate2D) {
        self.cityName = cityName
        self.cityCoordinates = cityCoordinates
    }
}
