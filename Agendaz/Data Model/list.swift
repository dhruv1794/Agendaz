//
//  list.swift
//  Agendaz
//
//  Created by Dhruv Mishra on 04/11/18.
//  Copyright © 2018 Dhruv Mishra. All rights reserved.
//

import Foundation

//Swift 3 below
//class List : Encodable, Decodable {
//    var title:String = "cxv"
//    var done:Bool = false
//}

//Swift 4 below
class List : Codable {
    var title:String = "cxv"
    var done:Bool = false
}
