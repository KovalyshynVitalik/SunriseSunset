//
//  RequestsManager.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/21/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import Foundation

class RequestsManager {
    
    static let shared = RequestsManager()
    
    private init() {}
    
    func getSunriseSunsetInfo(longitude: Double,latitude: Double, completionBlock: @escaping (SunriseSunsetModel) -> Void) {
        let request = GetSunriseSunsetInfoWithCoordinates()
        request.latitude = latitude
        request.longitude = longitude
        
        let urlSession = URLSession.shared
        
        guard let url = URL(string: request.requestURL) else { return }
        
        let getSunriseRequest = URLRequest(url: url)
        
        urlSession.dataTask(with: getSunriseRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let sunriseSunsetDataModel = try JSONDecoder().decode(SunriseSunsetModel.self, from: data)
                completionBlock(sunriseSunsetDataModel)
            } catch {
                print("ERROR OCCURED")
            }
        }.resume()
        
    }
    
}
