//
//  ViewController.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/21/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces

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
    var googlePlacesArray = [GooglePlaceModel]() {
        didSet {
            googlePlacesArray.forEach{ self.getSunriseSunsetInfoWithCoordinates($0.cityCoordinates.latitude, $0.cityCoordinates.longitude, cityName: $0.cityName) }
            
        }
    }
    
    //MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.locationManager.requestWhenInUseAuthorization()
        
        addRightBarButtonItemToNavigationController()
        
        getCurrentInfoWithCurrentLocation()
        getSunriseSunsetInfoWithCoordinates(51.509865, -0.118092, cityName: "London")
        getSunriseSunsetInfoWithCoordinates(47.751076, -120.740135, cityName: "Washington")
        getSunriseSunsetInfoWithCoordinates(35.652832, 139.839478, cityName: "Tokyo")
        getSunriseSunsetInfoWithCoordinates(32.109333, 34.855499, cityName: "Tel Aviv")
        getSunriseSunsetInfoWithCoordinates(49.842957, 24.031111, cityName: "Lviv")
        
    }

    //MARK: supp methods

    func addRightBarButtonItemToNavigationController() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SEARCH", style: .plain, target: self, action: #selector(autocompleteClicked))
    }
    
    @objc func autocompleteClicked(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        autocompleteController.placeFields = fields
        
        
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .noFilter
        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    func getSunriseSunsetInfoWithCoordinates(_ latitude: Double,_ longitude: Double,cityName: String? = nil) {
        RequestsManager.shared.getSunriseSunsetInfo(longitude: longitude , latitude: latitude) { (sunriseSunsetDataModel) in
            DispatchQueue.main.async {
                let results = Results(sunrise: sunriseSunsetDataModel.results?.sunrise, sunset: sunriseSunsetDataModel.results?.sunset, cityName: cityName, solar_noon: sunriseSunsetDataModel.results?.solar_noon, day_length: sunriseSunsetDataModel.results?.day_length, civil_twilight_begin: sunriseSunsetDataModel.results?.civil_twilight_begin, civil_twilight_end: sunriseSunsetDataModel.results?.civil_twilight_end)
                let model = SunriseSunsetModel(results: results)
                self.sunriseDataModels.append(model)
            }
        }
    }
    
    func getCurrentInfoWithCurrentLocation() {
        let coordinates = locationManager.location?.coordinate
        
        guard let latitude = coordinates?.latitude.magnitude,let longitude = coordinates?.longitude.magnitude else { return }
        getSunriseSunsetInfoWithCoordinates(latitude, longitude)
    }

}


//MARK: Table view delegate and datasource callbacks

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sunriseDataModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sunriseSunsetInfoCellId", for: indexPath) as! SunriseSunsetInfoTableViewCell
        
        let sunriseTimeStamp = self.sunriseDataModels[indexPath.row].results?.sunrise ?? ""
        let sunsetTimeStamp = self.sunriseDataModels[indexPath.row].results?.sunset ?? ""
        
//        cell.sunriseLabel.text! += SunriseSunsetDateFormatter.shared.getTimeStamp(with: sunriseTimeStamp)
//        cell.sunsetLabel.text! += SunriseSunsetDateFormatter.shared.getTimeStamp(with: sunsetTimeStamp)
        
        cell.sunriseLabel.text = "Sunrise at " + sunriseTimeStamp
        cell.sunsetLabel.text = "sunset at " + sunsetTimeStamp
        
        
        cell.cityNameLabel.text = self.sunriseDataModels[indexPath.row].results?.cityName ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let vc = DetailViewController()
//        vc.sunriseSunsetDataModel = self.sunriseDataModels[indexPath.row].results
//        self.navigationController?.pushViewController(vc, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "detail") as! DetailViewController
        controller.sunriseSunsetDataModel = self.sunriseDataModels[indexPath.row].results
        self.navigationController?.pushViewController(controller, animated: true)

    }
}


extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let googlePlaceDataModel = GooglePlaceModel(cityName: place.name ?? "", cityCoordinates: place.coordinate)
        self.googlePlacesArray.append(googlePlaceDataModel)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
