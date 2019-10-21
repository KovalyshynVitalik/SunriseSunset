//
//  GetSunriseSunsetInfoWithCoordinates.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/21/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import Foundation

class GetSunriseSunsetInfoWithCoordinates: AbstractRequest {
    
    var longitude: Double?
    var latitude: Double?
    
    override var urlParameters: [String : String]? {
        var queryParameters = [String:String]()
        
        if let longitude = longitude {
            queryParameters["lng"] = "\(longitude)"
        }
        
        if let latitude = latitude {
            queryParameters["lat"] = "\(latitude)"
        }
        
        return queryParameters
    }
}
