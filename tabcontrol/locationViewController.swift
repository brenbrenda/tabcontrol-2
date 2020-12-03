//
//  locationViewController.swift
//  tabcontrol
//
//  Created by chia on 2019/12/4.
//  Copyright © 2019 chia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
/*class wevser{
    static let shared = mydatatopass()
    var q = WebService1()
    private init() {  }
}*/
class locationViewController: UIViewController{
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var CityLocate: UILabel!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 3000
     //let regionInMeters: Double = 5000
    var previousLocation: CLLocation?
    var latitude:Double = 0.0
    var longtitude:Double = 0.0
    var a1:String = ""
    var a2:String = ""
    
    var userNam: String?
    let q = WebService1()
    var b1: String = ""
    
    let AQI_URL = "https://opendata.epa.gov.tw/ws/Data/AQI/?$format=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    var aqiArray :[AQI]?
    
    struct AQI: Codable{
        let SiteName:String?
        let County:String?
        let AQI:String?
        let PublishTime:String?
    }
    func getData() {
        if let url = URL(string: AQI_URL!) {
            
            let task = URLSession.shared.dataTask(with: url)
            {(data, response, error) in
                
                let decoder = JSONDecoder() //透過 JSONDecoder 幫助我們解開 API 資訊
              
                //透過decoder 將我們自己定義的型別帶入，讓decoder 自動幫我們把資料配對進型別中
                if let data = data , let result = try? decoder.decode([AQI].self, from: data){
                    
                    //取完資料後再將結果放進array中
                    self.aqiArray = result
                  
                    DispatchQueue.main.async {
                        //最後再重新讀取 tabelView 的資料一次
                       // self.aqiTabelView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b1 = q.imUser(ID: userNam!)
        checkLocationServices()
        getData()
        
        //AddressLabel.text = aqi
        
        
    }
    
    // 取得現在位置
        /*double X = myMapView.userLocation.location.coordinate.latitude;
        double Y = myMapView.userLocation.location.coordinate.longitude;
        NSLog(@"latitude: %f", X);
        NSLog(@"longitude: %f", Y);*/

    
    func setupLocationManager() {
//        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            map.setRegion(region, animated: true)
            a1 = String(location.latitude)
            a2 = String(location.longitude)
            //AddressLabel.text = a1 + a2
            let b2 = q.sendLocation(user: b1, latitude: a1, longtitude: a2)
            //AddressLabel.text = b1 + a1 + a2 + b2
        }
        
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        
        @unknown default:
            break
        }
    }
    
    func startTackingUserLocation() {
        map.showsUserLocation = true  //blue dot
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
//        previousLocation = getCenterLocation(for: map)
    }
    
    //get latitude & send

    func getCenterLocation(for map: MKMapView) -> CLLocation {
        latitude = map.centerCoordinate.latitude
        longtitude = map.centerCoordinate.longitude
        // a1 = "\(latitude)"
        // a2 = "\(longtitude)"
        // AddressLabel.text = a1
        sendLocationtoDataBase()
        return CLLocation(latitude: latitude, longitude: longtitude)
        
       }
    func sendLocationtoDataBase(){
           //let re = WebService1()
           //a1 = "\(latitude)"
           //a2 = "\(longtitude)"
           //let a8 :Int = re.sendLocation(user: "1", latitude: a1, longtitude: a2)
          //AddressLabel.text = a1 + "," + a2
    }
    
    
}


extension locationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}


extension locationViewController: MKMapViewDelegate {
    
    func map(_ map: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: map)
        let geoCoder = CLGeocoder()
        //
            
        
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 0 else { return }
        self.previousLocation = center
        
    
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            let streetCountry = placemark.country ?? ""
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
               // self.AddressLabel.text = "\(streetNumber) \(streetName) \(streetCountry)"
               // self.AddressLabel.text = String(map.centerCoordinate.latitude) + "," + String(map.centerCoordinate.longitude)
                
            }
        }
    }
}

/*extension locationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
           map.setRegion(region, animated: true)
        
       }
       
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           checkLocationAuthorization()
       }
*/
    

