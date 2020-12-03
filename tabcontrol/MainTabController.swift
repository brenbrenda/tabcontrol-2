//
//  MainTabController.swift
//  tabcontrol
//
//  Created by chia on 2019/12/4.
//  Copyright © 2019 chia. All rights reserved.
//

import Foundation
import UIKit

class MainTabController : UITabBarController{
    var userName: String?
    var password: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        /*guard let viewControllers = viewControllers else {
            return
        }
        for viewController in viewControllers {
            if let profileNavigationController = viewController as? ProfileNavigationViewController {
                
                if let Profile = profileNavigationController.viewControllers.first as? FirstViewController{
                    Profile.userName = userName
                    Profile.password = password
                }
            }
            
        }*/
        
    }
}
