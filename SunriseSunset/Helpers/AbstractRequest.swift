//
//  AbstractRequest.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/21/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import Foundation

class AbstractRequest {
    
    
    //MARK: base url for sunrise sunset api
    var baseURL = "https://api.sunrise-sunset.org/json"
    
    var url: String {
        get {
            return ""
        }
    }
    
    var urlParameters: [String: String]? {
        get {
            return nil
        }
    }
    
    var requestURL: String {
        get {
            
            // needed if api exists on web service
//            var urlParams = urlParameters ?? [String: String]()
            let parametersString = urlParameters?.map{ (parameter) -> String in
                let urlParam = "\(parameter.key)=\(parameter.value)"
                guard let urlParametersEncoded = urlParam.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return urlParam }
                return urlParametersEncoded
            }
            if let parametersString = parametersString, parametersString.count > 0 {
                let separator = parametersString.count > 0 ? "?" : ""
                let queryParams = parametersString.joined(separator: "&")
                return baseURL + url + separator + queryParams
            }
            
            return baseURL + url
        }
    }
}
