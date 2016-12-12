//
//  Colony.swift
//  GameofLife-iPad2
//
//  Created by Alex Cao & Harrison Wong on 11/28/2016.
//  Copyright © 2016 Alex Cao & Harrison Wong. All rights reserved.
//


import Foundation

class Colony : CustomStringConvertible {
    
    var name: String
    private var generationNum = 0
    var evolveNum = 0
    var aliveCells: Set<Cell> = []
    var neighborCells: Set<Cell> = []
    var date = NSDate()
    var wrapping = false
    
    init(name: String) {
        self.name = name
        self.date = NSDate()
    }
    
    func setWrapping(w: Bool) {
        wrapping = w
    }
    
    func setName(input: String) {
        name = input
    }
    
    func getName()-> String {
        return name
    }
    
    func setTemplate(input: String) {
        if input == "blank" {
            resetColony()
        }
        if input == "basic" {
            resetColony()
            setCellAlive(5, y: 5)
            setCellAlive(5, y: 6)
            setCellAlive(5, y: 7)
            setCellAlive(6, y: 6)
        }
        if input == "glidergun" {
            resetColony()
            setGliderGun()
        }
    }
    
    func getAliveCells()-> Set<Cell> {
        return aliveCells
    }
    
    func getGenerationNum()-> Int {
        return generationNum
    }
    
    func getEvolveNum()-> Int {
        return evolveNum
    }
    
    func getNumberCells()-> Int {
        return aliveCells.count
    }
    
    func isCellAlive(c: Cell)-> Bool {
        return aliveCells.contains(c)
    }
    
    func resetColony() {
        aliveCells.removeAll()
        generationNum = 0
    }
    
    func setCellAlive(x: Int, y: Int) {
        aliveCells.insert(Cell(xCoor: x, yCoor: y))
    }
    
    func setCellDead(x: Int, y: Int) {
        aliveCells.remove(Cell(xCoor: x, yCoor: y))
    }
    
    func isCellBeyondEdge(xCoor: Int, yCoor: Int) -> Bool {
        if xCoor < 0 || xCoor > 59 || yCoor < 0 || yCoor > 59 {
            return true
        } else {
            return false
        }
    }
    
    //Finds surrounding cells for the evolve method (kind of clunky, but I wasn't sure how else to make it work...)
    
    
    func surroundingCells(c: Cell) -> Int {
        var surround = 0
        if wrapping {
            if isCellAlive(fixCellsForWrapping(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor + 1))) {
                surround += 1
            }
            if isCellAlive(fixCellsForWrapping(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor))) {
                surround += 1
            }
            if isCellAlive(fixCellsForWrapping(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor - 1))) {
                surround += 1
            }
            if isCellAlive(fixCellsForWrapping(Cell(xCoor: c.xCoor, yCoor: c.yCoor + 1))) {
                surround += 1
            }
            if isCellAlive(fixCellsForWrapping(Cell(xCoor: c.xCoor, yCoor: c.yCoor - 1))) {
                surround += 1
            }
            if isCellAlive(fixCellsForWrapping(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor + 1))) {
                surround += 1
            }
            if isCellAlive(fixCellsForWrapping(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor))) {
                surround += 1
            }
            if isCellAlive(fixCellsForWrapping(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor - 1))) {
                surround += 1
            }
        } else {
            if isCellAlive(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor + 1)) {
                surround += 1
            }
            if isCellAlive(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor)) {
                surround += 1
            }
            if isCellAlive(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor - 1)) {
                surround += 1
            }
            if isCellAlive(Cell(xCoor: c.xCoor, yCoor: c.yCoor + 1)) {
                surround += 1
            }
            if isCellAlive(Cell(xCoor: c.xCoor, yCoor: c.yCoor - 1)) {
                surround += 1
            }
            if isCellAlive(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor + 1)) {
                surround += 1
            }
            if isCellAlive(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor)) {
                surround += 1
            }
            if isCellAlive(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor - 1)) {
                surround += 1
            }
        }
        return surround
        
    }
    
    func fixCellsForWrapping(c: Cell) -> Cell {
        if c.xCoor < 0 {
            if c.yCoor < 0 { return Cell(xCoor: 59, yCoor: 59) }
            else if c.yCoor > 59 { return Cell (xCoor: 59, yCoor: 0) }
            else { return Cell (xCoor: 59, yCoor: c.yCoor) }
        } else if c.xCoor > 59 {
            if c.yCoor < 0 { return Cell(xCoor: 0, yCoor: 59) }
            else if c.yCoor > 59 { return Cell (xCoor: 0, yCoor: 0) }
            else { return Cell (xCoor: 0, yCoor: c.yCoor) }
        } else {
            if c.yCoor < 0 { return Cell(xCoor: c.xCoor, yCoor: 59) }
            else if c.yCoor > 59 { return Cell (xCoor: c.xCoor, yCoor: 0) }
            else { return c }
        }
    }
    
    func evolve() {
        var testColony: Set<Cell> = []
        for c in aliveCells {
            testColony.insert(c)
            testColony.insert(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor + 1))
            testColony.insert(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor))
            testColony.insert(Cell(xCoor: c.xCoor + 1, yCoor: c.yCoor - 1))
            testColony.insert(Cell(xCoor: c.xCoor, yCoor: c.yCoor + 1))
            testColony.insert(Cell(xCoor: c.xCoor, yCoor: c.yCoor - 1))
            testColony.insert(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor + 1))
            testColony.insert(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor))
            testColony.insert(Cell(xCoor: c.xCoor - 1, yCoor: c.yCoor - 1))
        }
        if wrapping {
            var fixedColony: Set<Cell> = []
            for c in testColony {
                fixedColony.insert(fixCellsForWrapping(c))
            }
            testColony = fixedColony
        }
        var nextGeneration: Set<Cell> = []
        for c in testColony {
            let surrounding = surroundingCells(c)
            if !isCellBeyondEdge(c.xCoor, yCoor: c.yCoor) {
                if isCellAlive(Cell(xCoor: c.xCoor, yCoor: c.yCoor)) {
                    if surrounding == 2 || surrounding == 3 {
                        nextGeneration.insert(c)
                    }
                } else {
                    if surrounding == 3 {
                        nextGeneration.insert(c)
                    }
                }
            }
            
        }
        aliveCells = nextGeneration
        generationNum += 1
        
    }
    
    var description: String {
        return "\(name)"
    }
    
    func setGliderGun() {
        setCellAlive(6, y: 2)
        setCellAlive(6, y: 3)
        setCellAlive(7, y: 2)
        setCellAlive(7, y: 3)
        setCellAlive(4, y: 14)
        setCellAlive(4, y: 15)
        setCellAlive(5, y: 13)
        setCellAlive(5, y: 17)
        setCellAlive(6, y: 12)
        setCellAlive(6, y: 18)
        setCellAlive(7, y: 12)
        setCellAlive(7, y: 16)
        setCellAlive(7, y: 18)
        setCellAlive(7, y: 19)
        setCellAlive(8, y: 12)
        setCellAlive(8, y: 18)
        setCellAlive(9, y: 13)
        setCellAlive(9, y: 17)
        setCellAlive(10, y: 14)
        setCellAlive(10, y: 15)
        setCellAlive(4, y: 22)
        setCellAlive(4, y: 23)
        setCellAlive(5, y: 22)
        setCellAlive(5, y: 23)
        setCellAlive(6, y: 22)
        setCellAlive(6, y: 23)
        setCellAlive(3, y: 24)
        setCellAlive(3, y: 26)
        setCellAlive(2, y: 26)
        setCellAlive(7, y: 24)
        setCellAlive(7, y: 26)
        setCellAlive(8, y: 26)
        setCellAlive(4, y: 36)
        setCellAlive(4, y: 37)
        setCellAlive(5, y: 36)
        setCellAlive(5, y: 37)
    }
    
}
