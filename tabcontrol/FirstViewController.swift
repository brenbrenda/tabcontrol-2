//
//  ViewController.swift
//  tabcontrol
//
//  Created by chia on 2019/12/4.
//  Copyright © 2019 chia. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, GetData {
    func receiveData1(data1: String) {
        contact.text = data1
    }
    func receiveData2(data2: String) {
        contactnumber.text = data2
    }
    var changeCc: String = ""
    var changePp: String = ""
    var userName: String?
    var password: String?
    var now = Date()
    var dateformatter = DateFormatter()
    var YYYY: String = ""
    //var dataToBeSent = "傳回去的"
    //var delegate: DismissBackDelegate?
    //locate
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 3000
    var previousLocation: CLLocation?
    var latitude:Double = 0.0
    var longtitude:Double = 0.0
    var a1:String = ""
    var a2:String = ""
    var userNam:String?
    let q = WebService1()
    var b1: String = ""

   // var birthday: Date?

    @IBOutlet weak var Mapkit: MKMapView!
    @IBOutlet weak var name: UILabel!
    @IBAction func Logout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var contactnumber: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var sendLo: UILabel!
    

    
    override func viewDidAppear(_ animated: Bool) {
        let c = WebService1()
        name.text = c.name(ID: userName!)
        contact.text = c.contactfamily(ID: userName!)
        contactnumber.text = c.phone(ID: userName!, PS: password!)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        editButtonItem.isEnabled = true
        // Do any additional setup after loading the view.
        let q = WebService1()
//        see.text = self.password
        name.text = q.name(ID: userName!)
        contact.text = q.contactfamily(ID: userName!)
        contactnumber.text = q.phone(ID: userName!, PS: password!)
        let Yearr = String((userName?.prefix(4))!)
        let monthday = String((userName?.suffix(4))!)
        let Month = String(monthday.prefix(2))
        //let Day = monthday.suffix(2)
        dateformatter.dateFormat = "YYYY - MM - dd HH:mm:ss "
        let customDate = dateformatter.string(from: now)
        //let monthnow = customDate.suffix(2)
        let yearnowmo = String(customDate.prefix(9))
        let yearnow = String(yearnowmo.prefix(4))
        let monthnow = String(yearnowmo.suffix(2))
        let test: Int = Int(Yearr)!
        
         if Int(Month)! > Int(monthnow)!{
            let calY = Int(yearnow)! - test - 1
            let calM = 12 + Int(monthnow)! - Int(Month)!
            YYYY = String(calY)+"歲"+String(calM)+"個月"
            year.text = YYYY
        }
         else{
            let calY = Int(yearnow)! - test
            let calM = Int(monthnow)! - Int(Month)!
            YYYY = String(calY)+"歲"+String(calM)+"個月"
            year.text = YYYY
            b1 = q.imUser(ID: userName!)
        }
       
        //let calY = 2020 - test
        //year.text = String(calY)
        //birthday = NSDate(userName)
        
        //let birthday = string2Date(userName!, dateFormat: "yyyy-MM-dd") as NSDate
        //let now = Date()
        //let yy = now - birthday
        //let ageComponents = Calendar.dateComponents([.year], from: birthday, to: now)
        //let age = ageComponents.year
        
        if let measurementController = self.tabBarController?.viewControllers?[1] as? MeasurementController{
            if let inputText = userName {
                //measurementController.password = input2
                measurementController.username = inputText
                //self.tabBarController?.selectedIndex = 0
            }
        }
        /*if let locationViewController = self.tabBarController?.viewControllers?[2] as? locationViewController{
                   if let inputText = userName {
                       //measurementController.password = input2
                       locationViewController.userNam = inputText
                       //self.tabBarController?.selectedIndex = 2
                   }
               }*/
    }

        func setupLocationManager() {
    //        locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        
        func centerViewOnUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                Mapkit.setRegion(region, animated: true)
                a1 = String(location.latitude)
                a2 = String(location.longitude)
                let b2 = q.sendLocation(user: b1, latitude: a1, longtitude: a2)
                sendLo.text = b2
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
            Mapkit.showsUserLocation = true  //blue dot
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
        
        
    


  
    
    @IBAction func edit(_ sender: Any) {
        //let a = WebService1()
        //name.text = a.name(ID: userName!)
        
        contact.text = changeCc
        contactnumber.text = changePp
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /* if segue.identifier == "presentSegue" {
            if let ChangeVC = segue.destination as? ChangeContactViewController{
                ChangeVC.userName = userName
            }*/
        let changeVC = segue.destination as! ChangeContactViewController
        changeVC.userName = userName
        changeVC.YY = YYYY
        changeVC.delegate = self
        
    }
    
    
    
 }



    /*
 let custMainVC = segue.destination as! MainTabController
        //custMainVC.selectedViewController = custMainVC.viewControllers?[0]
        let res = custMainVC.viewControllers!.first as! FirstViewController
        res.userName = username.text
        res.password = password.text
        }
 func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    } */

 /*
extension FirstViewController: DismissBackDelegate{
    func dismissBack(sentData: Any) {
        changePp = sentData as! String
        contact.text = changeCc
        contactnumber.text = changePp
    }
} */
 
