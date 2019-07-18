//
//  ViewController.swift
//  Alamofire_JSON_API
//
//  Created by Nooruddin on 28/06/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, apiProtocol {
    


    let alamofireObj = ServicesManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func btnAdd(_ sender: UIBarButtonItem) {
        let secondViewController: SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.save = "Add"
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        alamofireObj.delegateProtocol = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        callAllEmployeeAPI()
        //self.tableView.reloadData()
    }
    
    
    
    
    
    
 
    func callAllEmployeeAPI(){
        alamofireObj.callLoginAPI(withURL: "http://dummy.restapiexample.com/api/v1/employees")
    }
    
    func getAllEmp(withList list: [[String : Any]]) {

        //print(list)
        for emp in list {
            if let name:String = emp["employee_name"] as? String {
                print("Employee_Name = \(name)")
            }
        }
        tableView.reloadData()
    }
    
  
    
    func deleteAllEmp(withList list: [[String : Any]]) {
        for emp in list {
            if let name:String = emp["employee_name"] as? String {
                print("Employee_Name = \(name)")
            }
        }
    }
    
    
    

    


    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alamofireObj.aryOfDictEmployees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell:TableViewCellVC = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCellVC {
            cell.lbl?.text = alamofireObj.aryOfDictEmployees[indexPath.row]["employee_name"] as! String
            return cell
        } else {
        return TableViewCellVC()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            alamofireObj.aryOfDictEmployees.remove(at: indexPath.row)
            var id = alamofireObj.aryOfDictEmployees[indexPath.row]["id"] as! String
            print(id)
            alamofireObj.callDeleteAPI(withURL: "http://dummy.restapiexample.com/api/v1/update/"+"\(id)")
            
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondViewController: SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        secondViewController.id = alamofireObj.aryOfDictEmployees[indexPath.row]["id"] as! String
        secondViewController.name = alamofireObj.aryOfDictEmployees[indexPath.row]["employee_name"] as! String
        secondViewController.salary = alamofireObj.aryOfDictEmployees[indexPath.row]["employee_salary"] as! String
        secondViewController.age = alamofireObj.aryOfDictEmployees[indexPath.row]["employee_age"] as! String
        
        secondViewController.save = "Update"
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    

}

