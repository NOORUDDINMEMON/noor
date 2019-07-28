//
//  ViewController.swift
//  API_Demo
//
//  Created by Nooruddin on 27/07/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var arrData = [jsonModal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        jsonParsing()
    }
    
    
    
    
    func jsonParsing() {
        let url = URL(string: "https://itunes.apple.com/search?media=music&term=bollywood")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else {return}
            do{
                let json = try JSON(data: data)
                let results = json["results"]
                
                for arr in results.arrayValue {
                    self.arrData.append(jsonModal(json: arr))
                    //print(arr["trackPrice"])
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(results)
                
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }


}





extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell {
            
            cell.lbl1.text = arrData[indexPath.row].artistName
            cell.lbl2.text = arrData[indexPath.row].trackCensoredName
            cell.img1.kf.setImage(with: URL(string: arrData[indexPath.row].artworkUrl60))
//            let url1 = NSURL(string: arrData[indexPath.row].artworkUrl60)!
//            let data1 = NSData(contentsOf: url1 as URL)!
//            cell.img1.image = UIImage(data: data1 as Data)
            
            let url = NSURL(string: "http://tineye.com/images/widgets/mona.jpg")!
            let data = NSData(contentsOf: url as URL)!
            cell.img2.image = UIImage(data: data as Data)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        //return UITableView.automaticDimension
    }
    
    
}

