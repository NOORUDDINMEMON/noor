//
//  ServicesManager.swift
//  Alamofire_JSON_API
//
//  Created by Nooruddin on 03/07/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//
import UIKit
import Foundation
import Alamofire

@objc protocol apiProtocol {

    @objc optional func getAllEmp(withList list:[[String:Any]])
    @objc optional func postAllEmp(withList list:[[String:Any]])
    @objc optional func putAllEmp(withList list:[[String:Any]])
    @objc optional func deleteAllEmp(withList list:[[String:Any]])
}

class ServicesManager {
    
    var aryOfDictEmployees = [[String:Any]]()
    var delegateProtocol: apiProtocol?
    var url:String = ""

    private func callGetRequest(withURL url:String){
        let url1: URL = URL.init(string: url)!
        var urlRequest = URLRequest.init(url: url1)
        urlRequest.httpMethod = "GET"
        
        Alamofire.request(urlRequest).responseJSON { (response) in
            //print(response)
            print("Status = \(response.result)")
            
            switch response.result {
            case let .success(jsonResponse):
                //print(jsonResponse)
                if let aryEmployees:[[String:Any]] = jsonResponse as? [[String:Any]] {
                    self.aryOfDictEmployees = aryEmployees

                    if self.delegateProtocol != nil {
                        self.delegateProtocol?.getAllEmp?(withList: self.aryOfDictEmployees)
                    }
                }
                break
            case let .failure(apiError):
                print(apiError)
            }
        }
    }
    func callLoginAPI(withURL url:String){
        self.callGetRequest(withURL: url)
    }
//    func callLoginAPI1(withURL url:String,withClouser  block:((response:[String:Any]?,success:Bool,error:Error?)->Void)?){
//        self.callGetRequest(withURL: String, perameters: <#T##[String : Any]?#>, withHeaderPerameters: <#T##[String : Any]?#>)s
//    }
    func callPostAPI(withURL url:String, parameters:[String:Any]) {
        self.postRequestAlamofire(url: url, postParameter: parameters)
    }

    
    //POST
    private func postRequestAlamofire(url: String, postParameter: [String:Any]) {
        
           let url:URL = URL.init(string: url)!
            var urlRequest = URLRequest.init(url: url)
            urlRequest.httpMethod = "POST"
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: postParameter, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                Alamofire.request(urlRequest).responseJSON { (response) in
                    //print(response)
                    print(response.result)
                    
                    switch response.result {
                    case let .success(jsonResponse):
                        print(jsonResponse)
                        if let aryEmployees:[[String:Any]] = jsonResponse as? [[String:Any]] {
                            self.aryOfDictEmployees = aryEmployees
                            
                            if self.delegateProtocol != nil {
                                self.delegateProtocol?.postAllEmp?(withList: self.aryOfDictEmployees)
                            }
                        }
                        break
                    case let .failure(apiError):
                        print(apiError)
                    }
                }
            } catch {}
        
    }
    
    func callPutAPI(withURL url:String, parameters:[String:Any]) {
        self.putRequestAlamofire(url: url, putParameter: parameters)
    }
    
    //PUT
    private func putRequestAlamofire(url: String, putParameter: [String:Any]) {
        
            let url:URL = URL.init(string: url)!
            var urlRequest = URLRequest.init(url: url)
            urlRequest.httpMethod = "PUT"
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: putParameter, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                Alamofire.request(urlRequest).responseJSON { (response) in
                    //print(response)
                    print(response.result)
                    
                    switch response.result {
                    case let .success(jsonResponse):
                        print(jsonResponse)
                        if let aryEmployees:[[String:Any]] = jsonResponse as? [[String:Any]] {
                            self.aryOfDictEmployees = aryEmployees
                            
                            if self.delegateProtocol != nil {
                                self.delegateProtocol?.putAllEmp?(withList: self.aryOfDictEmployees)
                            }
                        }
                        break
                    case let .failure(apiError):
                        print(apiError)
                    }
                }
            } catch {}
    }
    
    
    func callDeleteAPI(withURL url:String) {
        self.deleteRequestAlamofire(url: url)
    }
    
    //DELETE
    private func deleteRequestAlamofire(url: String) {
        
        let url:URL = URL.init(string: url)!
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = "DELETE"
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: Parameters.self, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            Alamofire.request(urlRequest).responseJSON { (response) in
                //print(response)
                print(response.result)
                
                switch response.result {
                case let .success(jsonResponse):
                    print(jsonResponse)
                    if let aryEmployees:[[String:Any]] = jsonResponse as? [[String:Any]] {
                        self.aryOfDictEmployees = aryEmployees
                        
                        if self.delegateProtocol != nil {
                            self.delegateProtocol?.deleteAllEmp?(withList: self.aryOfDictEmployees)
                        }
                    }
                    break
                case let .failure(apiError):
                    print(apiError)
                }
            }
        } catch {}
    }
    
    
}



