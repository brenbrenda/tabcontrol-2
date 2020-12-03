//
//  LogInViewController.swift
//  tabcontrol
//
//  Created by chia on 2019/12/4.
//  Copyright © 2019 chia. All rights reserved.
//
/*let re = WebService()
let w1 = re.Login1(ID: text1, PS: text2)


if w1 != nil
{
    let mainTabController = storyboard?.instantiateViewController(identifier: "MainTabController") as! MainTabController
    mainTabController.selectedViewController = mainTabController.viewControllers?[1]
    present(mainTabController, animated: true, completion: nil)
}
else if username.text="" && password.text=""
{
    labelWarn.text = "請輸入帳號密碼"
    return
    
}
else if w1 == nil
{
    labelWarn.text = "帳號密碼不正確"
    return
}
else
{
    labelWarn.text = "請再輸入一次"
}*/
import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate, NSURLConnectionDelegate {

    @IBOutlet weak var labelWarn: UILabel!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
       
        password.isSecureTextEntry = true
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    var dataToPass = ""
    
    @IBAction func LogInpress(_ sender: Any) {
        //get reference into Maintabcontroller
       
        username.delegate = self
        let text1: String = username.text!
        password.delegate = self
        let text2: String = password.text!
        
        
        let re = WebService1()
        let w1 = re.Login(ID: text1, PS: text2)
        if w1 == 1
        {
            //dataToPass = re.Login1(ID: text1, PS: text2)
            //performSegue(withIdentifier: "LogInViewController", sender: self)
            //let mainTabController = storyboard?.instantiateViewController(identifier: "MainTabController") as! MainTabController
            
            //mainTabController.selectedViewController = mainTabController.viewControllers?[0]
            //present(mainTabController, animated: true, completion: nil)
        }
        else if w1 == 0
        {
            let alert = UIAlertController(title: "錯誤", message: "帳號密碼不正確", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
            labelWarn.text = "帳號密碼不正確"
            return
            
        }
        else if w1 == 3
        {
            let alert = UIAlertController(title: "注意", message: "您未輸入帳號密碼", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
            labelWarn.text = "未輸入帳號密碼"
            return
        }
        else 
        {
            let alert = UIAlertController(title: "錯誤", message: "請再輸入一次", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
                       present(alert, animated: true)
            labelWarn.text = "請再輸入一次"
            return
        }
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /* if let maintabController = segue.destination as? FirstViewController {
            maintabController.userName = username.text
            maintabController.password = password.text*/
        let custMainVC = segue.destination as! MainTabController
        //custMainVC.selectedViewController = custMainVC.viewControllers?[0]
        let res = custMainVC.viewControllers!.first as! FirstViewController
        res.userName = username.text
        res.password = password.text
        }
        
    }
          
        
       // theRequest.addValue("\(countElements(soapMessage))", forHTTPHeaderField: "Content-Length")
       
       //let mainTabController = storyboard?.instantiateViewController(identifier: "MainTabController") as! MainTabController
        //mainTabController.selectedViewController = mainTabController.viewControllers?[1]
        //present(mainTabController, animated: true, completion: nil)
    
    
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


