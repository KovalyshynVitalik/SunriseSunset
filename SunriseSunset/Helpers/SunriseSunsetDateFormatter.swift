//
//  SunriseSunsetDateFormatter.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/24/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import Foundation

class SunriseSunsetDateFormatter {

    static let shared = SunriseSunsetDateFormatter()
    
    
    private init(){
        toStringDateFormatter.dateFormat = "HH:mm"
    }
    
    let isoDateFormatter = ISO8601DateFormatter()
    let toStringDateFormatter = DateFormatter()
    
    func minusTimeZoneDifferenceFromDate(_ isoDate: Date) -> Date {
        let convertedToTimeZoneDate = Calendar.current.date(byAdding: .second, value: -TimeZone.current.secondsFromGMT(), to: isoDate)
        return convertedToTimeZoneDate ?? Date()
    }
    
    func getTimeStamp(with isoStyleDateString: String) -> String {
        let date = isoDateFormatter.date(from: isoStyleDateString) ?? Date()
        
        let minusTimeZoneDate = minusTimeZoneDifferenceFromDate(date)

        return toStringDateFormatter.string(from: minusTimeZoneDate)
    }
    
}
