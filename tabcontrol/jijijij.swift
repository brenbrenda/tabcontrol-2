//
//  jijijij.swift
//  tabcontrol
//
//  Created by chia on 2020/2/18.
//  Copyright © 2020 chia. All rights reserved.
//

import UIKit

class jijijij: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getXMLDataFromServer()
        /*let session = URLSession.shared
        //http://120.125.78.68/WebService1.asmx/Login1
        let url = "http://120.125.78.68/WebService1.asmx/Login1"
        let dataTask = session.dataTask(with: URL(string:url)!) { (data, response, error) in
            print("\(data)")
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                print(parsedData)

            } catch let error as NSError {
                print(error)
            }
            print("\(response)")
        }
        dataTask.resume()*/

        // Do any additional setup after loading the view.
    }
    
    func getXMLDataFromServer(){
        let url = NSURL(string: "http://120.125.78.68/WebService1.asmx/Login1")
         
        //Creating data task
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
             
            if data == nil {
                print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                return
            }
             
            let parser = XMLParser(data: data!)
            parser.delegate = self as! XMLParserDelegate
            parser.parse()
             
        }
         
        task.resume()
      
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
