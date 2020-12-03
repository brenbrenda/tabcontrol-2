//
//  MeasurementController.swift
//  tabcontrol
//
//  Created by chia on 2019/12/15.
//  Copyright © 2019 chia. All rights reserved.
//

import UIKit

/*class MyDataToPass {
       static let shared = MyDataToPass()
       var data = ""
       private init() {  }
 }*/
class MeasurementController: UIViewController{
    
    //var jsonObj: [[String: String]]!
    var timer: Timer?
    @IBOutlet weak var TEM: UILabel!
    @IBOutlet weak var humid: UILabel!
    @IBOutlet var Progressbar: UIView!
    @IBOutlet weak var homelabel: UILabel!
    @IBOutlet weak var pmColor: UITextView!
    @IBOutlet weak var ch4Color: UITextView!
    @IBOutlet weak var CO2: UILabel!
    @IBOutlet weak var co2Colot: UITextView!
    let progress = Progress(totalUnitCount: 50)
    var username: String?
    var password:String?
        
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let q = WebService1()
        let a7 = q.name(ID: username!)
        homelabel.text = a7+"的家"
        let room = q.Roommm(ID: username!)
        let a1 = q.value(item: "PM2.5", roomid: room)
        if(a1 == 0){
            let alert = UIAlertController(title: "注意", message: "請接上電源", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        else{
            
            let a1 = q.value(item: "PM2.5", roomid: room)
            let a2 = q.value(item: "CO", roomid: room)
            let a3 = q.value(item: "Hum", roomid: room)
            let a4 = q.value(item: "Tem", roomid: room)
            let a5 = q.value(item: "CO2", roomid: room)
            let a6 = q.value(item: "CH4", roomid: room)
            
            
            PM25.text = String(a1)+"μm"
            CO.text = String(a2)+"ppm"
            TEM.text = String(a4)+"℃"
            humid.text = String(a3)+"%"
            CO2.text = String(a5)+"ppm"
            CH4.text = String(a6)+"ppm"
            //pm2.5
            if(a1 >= 0 && a1 < 35){
                pmColor.text = "低"
                pmColor.backgroundColor = UIColor.green
            }
            else if (a1 >= 36 && a1 < 53){
                pmColor.text = "中"
                pmColor.backgroundColor = UIColor.yellow
            }
            else if(a1 >= 54 && a1<70){
                pmColor.text = "高"
                pmColor.backgroundColor = UIColor.orange
            }
            else {
                pmColor.text = "非常高"
                pmColor.textColor = UIColor.white
                pmColor.backgroundColor = UIColor.red
            }
           
            //co
            if(a2 >= 0 && a2 < 100){
                COcolor.text = "低"
                COcolor.backgroundColor = UIColor.green
            }
            else if (a2 >= 101 && a2 < 800){
                COcolor.text = "中"
                COcolor.backgroundColor = UIColor.yellow
            }
            else if(a2 >= 801 && a2 < 3200){
                COcolor.text = "高"
                COcolor.backgroundColor = UIColor.orange
            }
            else if(a2 > 3201){
                COcolor.text = "非常高"
                COcolor.textColor = UIColor.white
                COcolor.backgroundColor = UIColor.red
            }
            //co2
            if(a5 >= 0 && a5 < 400){
                co2Colot.text = "低"
                co2Colot.backgroundColor = UIColor.green
            }
            else if (a5 >= 401 && a5 < 999){
                co2Colot.text = "中"
                co2Colot.backgroundColor = UIColor.yellow
            }
            else if(a5 > 1000){
                co2Colot.text = "非常高"
                co2Colot.textColor = UIColor.white
                co2Colot.backgroundColor = UIColor.red
            }
            //ch4
            if(a6 >= 0 && a6 < 100){
                ch4Color.text = "低"
                ch4Color.backgroundColor = UIColor.green
            }
            else if (a6 >= 101 && a6 < 800){
                ch4Color.text = "中"
                ch4Color.backgroundColor = UIColor.yellow
            }
            else if(a6 >= 801 && a6 < 3200){
                ch4Color.text = "高"
                ch4Color.backgroundColor = UIColor.orange
            }
            else if(a6 > 3201){
                ch4Color.text = "非常高"
                ch4Color.textColor = UIColor.white
                ch4Color.backgroundColor = UIColor.red
            }
        }
        // Do any additional setup after loading the view.
       
    }
    

    @IBOutlet weak var COcolor: UITextView!
    @IBOutlet weak var PM25: UILabel!
    @IBOutlet weak var CO: UILabel!
    @IBOutlet weak var CH4: UILabel!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
