//
//  SecondViewController.swift
//  CoreDataDemo
//
//  Created by Nooruddin on 12/06/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit

protocol DataPass {
    func data(object: [String:String], index: Int, isEdit:Bool)
}

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var student = [Student]()
    var delegate: DataPass!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        student = DatabaseHelper.shareInstance.getStudentData()
    }
    


    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return DatabaseHelper.shareInstance.getStudentData().count
        return student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CoreDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CoreDataTableViewCell
        cell.student = student[indexPath.row]
//        cell.lbl1.text = student[indexPath.row].name
//        cell.lbl2.text = student[indexPath.row].city
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            student = DatabaseHelper.shareInstance.deleteData(index: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = ["name": student[indexPath.row].name, "city": student[indexPath.row].city]
        delegate.data(object: dict as! [String:String], index: indexPath.row, isEdit: true)
        
        self.navigationController?.popViewController(animated: true)
    }
   
    
}
