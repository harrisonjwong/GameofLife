//
//  Cell.swift
//  GameofLife-iPad2
//
//  Created by Alex Cao & Harrison Wong on 11/28/2016.
//  Copyright © 2016 Alex Cao & Harrison Wong. All rights reserved.
//

import Foundation

func ==(left: Cell, right: Cell)-> Bool {
    if (left.xCoor == right.xCoor && left.yCoor == right.yCoor) {
        return true
    } else {
        return false
    }
}

struct Cell : CustomStringConvertible, Hashable {
    
    var xCoor: Int
    var yCoor: Int
    var hashValue: Int {
        get {
            return "\(xCoor), \(yCoor)".hashValue
        }
    }
    
    init(xCoor: Int, yCoor: Int) {
        self.xCoor = xCoor
        self.yCoor = yCoor
    }
    
    func getX()-> Int {
        return xCoor
    }
    
    func getY()-> Int {
        return yCoor
    }
    
    var description: String {
        return "(\(xCoor), \(yCoor))"
    }
}
