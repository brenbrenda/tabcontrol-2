//
//  HUM.swift
//  tabcontrol
//
//  Created by chia on 2019/12/24.
//  Copyright © 2019 chia. All rights reserved.
//

import UIKit

class HUM: UIViewController, XMLParserDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://120.125.78.203/WebService.asmx")
        do{
            let html = try String(contentsOf: url!)
            print(html)
        } catch
        {
            print(error)
        }
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
