//
//  ViewController.swift
//  API_Alamofire
//
//  Created by Nooruddin on 31/07/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit
import Alamofire

struct jsonAPI {
    var name:String?
    var address:Address
}
struct Address {
    var street:String?
}

class ViewController: UIViewController {
    
    var nameDictionary = [[String:Any]]()
    var addressDictionary = [[String:Any]]()
    var geoDictionary = [[String:Any]]()
    var companyDictionary = [[String:Any]]()
    var structObj = [jsonAPI]()

    @IBOutlet weak var tableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //http://jsonplaceholder.typicode.com/users/
        getAlamofireAPI()
    }

    func getAlamofireAPI() {
        let api:String = "http://jsonplaceholder.typicode.com/users/"
        
        Alamofire.request(api, method: .get).responseJSON { response in
            
            if let json = response.value as? [[String:Any]] {
                
                for arr in json {
                    self.nameDictionary.append(arr)
                }
                for arr3 in json {
                    self.companyDictionary.append(arr3["company"] as! [String : Any])
                }
                for arr1 in json {
                    self.addressDictionary.append(arr1["address"] as! [String : Any])
                }
                for arr2 in self.addressDictionary {
                    self.geoDictionary.append(arr2["geo"] as! [String : Any])
                }
            }
            self.tableView.reloadData()
            //print(self.nameDictionary)
            //print(self.addressDictionary)
            print(self.geoDictionary)
            print(response.result)
            
        }
    }
    


}






extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell {
//
//            cell.nameLabel.text = self.json1[indexPath.row]["street"] as! String
//
//            return cell
//        }
//        return UITableViewCell()
        let cell:UITableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.nameDictionary[indexPath.row]["name"] as! String
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableViewController:TableViewController = self.storyboard?.instantiateViewController(identifier: "TableViewController") as! TableViewController
                
        tableViewController.name = nameDictionary[indexPath.row]["name"] as! String
        tableViewController.username = nameDictionary[indexPath.row]["username"] as! String
        tableViewController.companyname = companyDictionary[indexPath.row]["name"] as! String
        tableViewController.long = geoDictionary[indexPath.row]["lng"] as! String
        tableViewController.stret = addressDictionary[indexPath.row]["street"] as! String
                
        self.navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    
}
