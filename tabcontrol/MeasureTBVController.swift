//
//  TableViewController.swift
//  APItest
//
//  Created by chia on 2019/12/3.
//  Copyright © 2019 chia. All rights reserved.


import UIKit

class MeasureTBVController: UITableViewController {
    
    var jsonObj: [[String: String]]!


    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string:  "http://opendata.epa.gov.tw/webapi/Data/REWIQA/?$orderby=SiteName&$skip=0&$top=1000&format=json")
        let data = try! Data(contentsOf: url!)
        jsonObj = try! JSONSerialization.jsonObject(with: data,
            options: .allowFragments) as! [[String: String]]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jsonObj.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = (jsonObj[indexPath.row])["County"]! + (jsonObj[indexPath.row])["SiteName"]!
        cell.detailTextLabel?.text = (jsonObj[indexPath.row])["AQI"]

        let a:Int? = cell.detailTextLabel?.text?.toInt()
        if(a! >= 0 && a! < 51)
        {
            cell.detailTextLabel?.text! += "正常"
        }
        else if(a! >= 51 && a! < 101){
            cell.detailTextLabel?.text! += "普通"
            //cell.detailTextLabel?.textColor = UIColor.yellow
        }
        else if(a! >= 101 && a! < 200){
            cell.detailTextLabel?.textColor = UIColor.orange
        }
        else if(a! >= 200 && a! < 300){
            cell.detailTextLabel?.textColor = UIColor.red
        }
        else if(a! >= 300 && a! < 501){
            cell.detailTextLabel?.textColor = UIColor.purple
        }
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
