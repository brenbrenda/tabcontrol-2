//
//  ChangeContactViewController.swift
//  tabcontrol
//
//  Created by chia on 2020/2/24.
//  Copyright © 2020 chia. All rights reserved.
//

import UIKit
protocol GetData: class{
    func receiveData1(data1: String)
    func receiveData2(data2: String)
}
class ChangeContactViewController: UIViewController,UITextFieldDelegate {
    var changeC: String = ""
    var changeP: String = ""
    var userName: String?
    var YY: String = ""
    
 //   var delegate: GetData?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var changeContact: UITextField!
    @IBOutlet weak var changePhone: UITextField!
    
    weak var delegate: GetData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let q = WebService1()
        name.text = q.name(ID: userName!)
        year.text = YY
        //changeP = q.changephone(ID: userName!, phone: changePhone.text!)
        

        // Do any additional setup after loading the view.
    }
    @IBAction func clickDismiss(_ sender: UIButton) {
        
        if let text1 = changeContact.text, text1.isEmpty
        {
            let alert = UIAlertController(title: "未填寫", message: "請確實填寫", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "好", style: .default, handler: nil))
            present(alert, animated: true)
            
        }
        else{
            let q = WebService1()
        
            changeC = q.changecontactfam(ID: userName!, contactN: changeContact.text!)
            changeP = q.changephone(ID: userName!, phone: changePhone.text!)
            delegate?.receiveData1(data1: changeC)
            delegate?.receiveData2(data2: changeP)
            dismiss(animated: true, completion: nil)
            //delegate?.dismissBack(sentData: changeP)
            //dismiss(animated: true)
           
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
