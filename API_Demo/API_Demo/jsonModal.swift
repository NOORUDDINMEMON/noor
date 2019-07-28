//
//  jsonModal.swift
//  API_Demo
//
//  Created by Nooruddin on 27/07/19.
//  Copyright © 2019 Nooruddin. All rights reserved.
//

import Foundation

struct jsonModal {
    
    var artistName:String = ""
    var trackCensoredName:String = ""
    var artworkUrl60:String = ""
    
    init() {}
    
    init(json:JSON) {
        artistName = json["artistName"].stringValue
        trackCensoredName = json["trackCensoredName"].stringValue
        artworkUrl60 = json["artworkUrl60"].stringValue
    }
}
