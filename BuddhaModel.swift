//
//  BuddhaModel.swift
//  TestBuddha
//
//  Created by Zhang on 11/08/2017.
//  Copyright © 2017 Zhang. All rights reserved.
//

import UIKit


class BuddhaModel: NSObject {

    var n:String!
    var w:String!
    var a:String!
    var m:String!
    var t:String!
    var f:String!
    
    override init() {
        super.init()
    }
    
    init(dic:NSDictionary) {
        super.init()
        self.n = dic["n"] as! String
        self.w = dic["w"] as! String
        self.a = dic["a"] as! String
        self.m = dic["m"] as! String
        self.t = dic["t"] as! String
        self.f = dic["f"] as! String
    }
}

class BuddhaIndexModel: NSObject {
    
    var index:String!
    var buddha:BuddhaModel!
    var desc:String!
    var dessc:String!
    override init() {
        super.init()
    }
}
