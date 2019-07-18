//
//  SecondViewController.swift
//  Alamofire_JSON_API
//
//  Created by Nooruddin on 29/06/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit
import Alamofire

class SecondViewController: UIViewController, apiProtocol {
    
    
    @IBOutlet weak var emp_id: UITextField!
    @IBOutlet weak var emp_name: UITextField!
    @IBOutlet weak var emp_salary: UITextField!
    @IBOutlet weak var emp_age: UITextField!
    @IBOutlet weak var Save: UIButton!
    
    let alamofireObj = ServicesManager()
    
    var id = ""
    var name = ""
    var salary = ""
    var age = ""
    var save = ""
    
    
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        //POST
        if save == "Add" {
            
            var parameter: [String:Any] = [:]
            parameter["name"] = emp_name.text
            parameter["salary"] = emp_salary.text
            parameter["age"] = emp_age.text
            
            alamofireObj.callPostAPI(withURL: "http://dummy.restapiexample.com/api/v1/create", parameters: parameter)
            }
        else {
            
            var parameter: [String:Any] = [:]
            parameter["name"] = emp_name.text
            parameter["salary"] = emp_salary.text
            parameter["age"] = emp_age.text
            
            alamofireObj.callPutAPI(withURL: "http://dummy.restapiexample.com/api/v1/update/"+emp_id.text!, parameters: parameter)
        }
    
    }
    
    
    func postAllEmp(withList list: [[String : Any]]) {
        for emp in list {
            if let name:String = emp["employee_name"] as? String {
                print("Employee_Name = \(name)")
            }
        }
    }
    
    func putAllEmp(withList list: [[String : Any]]) {
        for emp in list {
            if let name:String = emp["employee_name"] as? String {
                print("Employee_Name = \(name)")
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emp_id.text = id
        emp_name.text = name
        emp_salary.text = salary
        emp_age.text = age
        Save.setTitle(save, for: .normal)
        print(save)
        
        if save == "Add" {
            emp_id.isEnabled = false
        } else {
            emp_id.isEnabled = true
        }
        
        alamofireObj.delegateProtocol = self
    }
    
    


}
