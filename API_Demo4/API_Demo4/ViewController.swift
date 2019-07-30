//
//  ViewController.swift
//  API_Demo4
//
//  Created by Nooruddin on 29/07/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit

struct jsonData:Decodable {
    var name:String?
    var username:String?
    var address:Address?
}
struct Address:Decodable {
    var street:String?
    var city:String?
    var zipcode:String?
}

class ViewController: UIViewController {
    
    var json1 = [jsonData]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getAPI_DATA()
    }

    
    
    
    func getAPI_DATA() {
        
      let url = URL(string: "http://jsonplaceholder.typicode.com/users/")
       URLSession.shared.dataTask(with: url!) { (data, response, error) in
                   
                   guard let data = data else {return}
                   do{
                    self.json1 = try JSONDecoder().decode([jsonData].self, from: data)
                       
                       DispatchQueue.main.async {
                           self.tableView.reloadData()
                       }
                   }catch{
                       print(error.localizedDescription)
                   }
               }.resume()
        
    }
    
    
    
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.json1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell {
            
            cell.usernameLabel.text = json1[indexPath.row].username
            cell.streetLabel.text = json1[indexPath.row].address?.street
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableViewController:TableViewController = self.storyboard?.instantiateViewController(identifier: "TableViewController") as! TableViewController
        
        tableViewController.json2 = json1[indexPath.row]
        print(tableViewController.json2)
        
        self.navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    
}
