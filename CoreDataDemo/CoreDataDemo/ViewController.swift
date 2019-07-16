//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Nooruddin on 11/06/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataPass {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    var i = Int()
    var isUpdate = Bool()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnShow(_ sender: Any) {
        let secondViewController: SecondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.delegate = self
        
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    
    
    func data(object: [String : String], index: Int, isEdit: Bool) {
        txtName.text = object["name"]
        txtCity.text = object["city"]
        i = index
        isUpdate = isEdit
    }
    
    
    
    @IBAction func btnSave(_ sender: Any) {
        
        let dict = ["name":txtName.text, "city":txtCity.text]
        if isUpdate {
            DatabaseHelper.shareInstance.editData(object: dict as! [String : String], i: i)
        } else {
            DatabaseHelper.shareInstance.save(object: dict as! [String : String])
        }
        
        txtName.text = ""
        txtCity.text = ""
    }
    
}

