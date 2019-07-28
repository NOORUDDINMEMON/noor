//
//  ViewController.swift
//  API_Demo3
//
//  Created by Nooruddin on 28/07/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit

struct jsonStruct:Decodable {
    var results:[Results]
}
struct Results:Decodable {
    var artworkUrl30:String?
    var artworkUrl60:String?
    var artworkUrl00:String?
}




class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var arrData = [Results]()
    //let arrayResult = []()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    
    
    
    func getData() {
            let url = URL(string: "https://itunes.apple.com/search?media=music&term=bollywood")
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                
                do{
                    if error == nil {
                        let array = try JSONDecoder().decode(jsonStruct.self, from: data!)
                        self.arrData = array.results
                        print(self.arrData)
                    }
                }catch{
                    print("Error in json data")
                }
                
            }.resume()
        }
    
    //cell.img1.kf.setImage(with: URL(string: arrData[indexPath.row].artworkUrl60))
    
    //TABLEVIEW DELEGATE METHODS
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell {
            
            cell.img1.kf.setImage(with: URL(string: arrData[indexPath.row].artworkUrl30!))
            cell.img2.kf.setImage(with: URL(string: arrData[indexPath.row].artworkUrl60!))
            
            guard arrData[indexPath.row].artworkUrl00 != nil else {return cell}
            if let url = NSURL(string: arrData[indexPath.row].artworkUrl00!) {
                if let data = NSData(contentsOf: url as URL) {
                    cell.img3.image = UIImage(data:data as Data)
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

}

