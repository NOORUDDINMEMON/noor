//
//  ViewController.swift
//  API_Demo2
//
//  Created by Nooruddin on 28/07/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit

struct jsonStruct:Decodable {
    var name:String?
    var capital:String?
    var alpha3Code:String?
}

class ViewController: UIViewController {
    
    var arrData = [jsonStruct]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }

    
    
    func getData() {
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            do{
                if error == nil {
                    self.arrData = try JSONDecoder().decode([jsonStruct].self, from: data!)
                    
                    for mainArray in self.arrData {
                        print(mainArray.name!,":",mainArray.capital!,":",mainArray.alpha3Code!)
                    }
                }
            }catch{
                print("Error in json data")
            }
            
        }.resume()
    }
    
    
    
    
    
}

