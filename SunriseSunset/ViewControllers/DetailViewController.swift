//
//  DetailViewController.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/24/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var sunriseSunsetDataModel: Results?
    
    var information: SunriseSunsetModel?

    @IBOutlet weak var solarNoonInfoLabel: UILabel!
    @IBOutlet weak var dayLengthInfoLabel: UILabel!
    @IBOutlet weak var civilTwilightBeginInfoLabel: UILabel!
    @IBOutlet weak var civilTwilightEndInfoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sunriseSunsetPhoto")
        backgroundImage.contentMode = UIView.ContentMode.scaleToFill
        self.view.insertSubview(backgroundImage, at: 0)
        if let unwrappedModel = sunriseSunsetDataModel {
            populateUIWithModel(unwrappedDataModel: unwrappedModel)
        }
    }
    
    
    func populateUIWithModel(unwrappedDataModel: Results) {
        self.solarNoonInfoLabel.text = "Solar noon - " + (unwrappedDataModel.solar_noon ?? "")
        self.dayLengthInfoLabel.text = "Day length - " + (unwrappedDataModel.day_length ?? "")
        self.civilTwilightEndInfoLabel.text = "Civil twilight end - " + (unwrappedDataModel.civil_twilight_end ?? "")
        self.civilTwilightBeginInfoLabel.text = "Civil twilight begin - " + (unwrappedDataModel.civil_twilight_begin ?? "")
    }

}
