//
//  SearchViewController.swift
//  SunriseSunset
//
//  Created by Vitalik on 10/22/19.
//  Copyright © 2019 VitalikKovalyshyn. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblPlaces: UITableView!
    var resultsArray: [Dictionary<String, AnyObject>] = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearch.addTarget(self, action: #selector(searchPlaceFromGoogle(_:)), for: .editingChanged)
        tblPlaces.estimatedRowHeight = 44.0
        txtSearch.delegate = self
        tblPlaces.dataSource = self
        tblPlaces.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell")
        if let lblPlaceName = cell?.contentView.viewWithTag(102) as? UILabel {
            
            let place = self.resultsArray[indexPath.row]
            lblPlaceName.text = "\(place["formatted_address"] as! String)"
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchPlaceFromGoogle(place: textField.text!)
//        return true
//    }
    
    @objc func searchPlaceFromGoogle(_ textField:UITextField) {
    
    if let searchQuery = textField.text {
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(searchQuery)&key= AIzaSyDhGlZaeujbw26MnoLfTWJXBg0He-9dQks"
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
            if error == nil {
                
                if let responseData = data {
                let jsonDict = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    
                    if let dict = jsonDict as? Dictionary<String, AnyObject>{
                        
                        if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                            print("json == \(results)")
                            print("json == \(jsonDict)")
                            self.resultsArray.removeAll()
                            for dct in results {
                                self.resultsArray.append(dct)
                            }
                            
                            DispatchQueue.main.async {
                             self.tblPlaces.reloadData()
                            }
                            
                        }
                    }
                   
                }
            } else {
                //we have error connection google api
            }
        }
        task.resume()
    }
    }
}
