//
//  ViewController.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/21/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //MARK: outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: properties
    let locationManager = CLLocationManager()
    var sunriseDataModels = [SunriseSunsetModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var someCode = "string"
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.locationManager.requestWhenInUseAuthorization()
        
        getCurrentInfoWithCoordinates()
    }

    //MARK: supp methods
    
    func getCurrentInfoWithCoordinates() {
        print()
        
        let coordinates = locationManager.location?.coordinate
        
        guard let latitude = coordinates?.latitude.magnitude,let longitude = coordinates?.longitude.magnitude else { return }
        RequestsManager.shared.getSunriseSunsetInfo(longitude: longitude , latitude: latitude) { (sunriseSunsetDataModel) in
            DispatchQueue.main.async {
                self.sunriseDataModels.append(sunriseSunsetDataModel)
            }
        }
    }

}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sunriseDataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sunriseSunsetInfoCellId", for: indexPath) as! SunriseSunsetInfoTableViewCell
        cell.sunriseLabel.text! += self.sunriseDataModels[indexPath.row].results?.sunrise ?? ""
        cell.sunsetLabel.text! += self.sunriseDataModels[indexPath.row].results?.sunset ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
