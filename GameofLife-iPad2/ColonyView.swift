//
//  ColonyView.swift
//  GameofLife-iPad2
//
//  Created by Alex Cao & Harrison Wong on 11/30/2016.
//  Copyright © 2016 Alex Cao & Harrison Wong. All rights reserved.
//

import UIKit

class ColonyView: UIView {
    
    var graphicColony = [CGRect]()
    var colony: Colony!
    let dimensions: CGFloat = 60
    var border = CGRect()
    var graphicEdit: Bool = true //true means addCell, false means removeCell
    
    func makeFrame(rect: CGRect) -> CGRect {
        let rectangle = CGRect(x: 0, y: 0, width: 663.5, height: 657.0)
        let rectWidth = rectangle.width
        let rectHeight = rectangle.height
        if rectWidth > rectHeight {
            let r = rectangle.insetBy(dx: 100 + (0.5 * (rectWidth - rectHeight)), dy: 100)
            return r
        } else if rectWidth < rectHeight {
            let r = rectangle.insetBy(dx: 100, dy: 100 + (0.5 * (rectHeight - rectWidth)))
            return r
        } else {
            let r = rectangle.insetBy(dx: 100, dy: 100)
            return r
        }
    }
    
    func updateGraphic() {
//        print(#function)
        graphicColony = []
        for cell in colony.aliveCells {
            addCell(cell.xCoor, yCoor: cell.yCoor)
        }
        setNeedsDisplay()   //updates it after evolving
    }
    
    override func drawRect(rect: CGRect) {
//        print(#function)
        border = makeFrame(rect)
        let borderPath = UIBezierPath(rect: border)
        borderPath.stroke()
        
        UIColor.blackColor().setStroke()
        for cells in graphicColony {
            strokeCell(cells)
        }
    }
    
    func strokeCell(c: CGRect) {
        let path = UIBezierPath(rect: c)

        path.fill()
    }
    
    func convertPixelToCoorX(x: CGFloat) -> Int {
        return Int(floor((x - makeFrame(bounds).minX)/(makeFrame(bounds).width/60)))
    }
    
    func convertPixelToCoorY(y: CGFloat) -> Int {
        return Int(floor((y - makeFrame(bounds).minY)/(makeFrame(bounds).height/60)))
    }
    
    func convertCoorToGridX(x: Int) -> CGFloat {
        return makeFrame(bounds).minX + CGFloat(x)*(makeFrame(bounds).width/dimensions)
    }
    
    func convertCoorToGridY(y: Int) -> CGFloat {
        return makeFrame(bounds).minY + CGFloat(y)*(makeFrame(bounds).height/dimensions)
    }
    
    func addCell(xCoor: Int, yCoor: Int)-> String {
        let aCell = CGRect(x: convertCoorToGridX(xCoor), y: convertCoorToGridY(yCoor), width: makeFrame(bounds).width/dimensions, height: makeFrame(bounds).height/dimensions)
        colony.setCellAlive(xCoor, y: yCoor)
        graphicColony.append(aCell)
        return "(\(xCoor), \(yCoor))"
    }
    
    func removeCell(xCoor: Int, yCoor: Int)-> String {
        let aCell = CGRect(x: convertCoorToGridX(xCoor), y: convertCoorToGridY(yCoor), width: makeFrame(bounds).width/dimensions, height: makeFrame(bounds).height/dimensions)
        colony.setCellDead(xCoor, y: yCoor)
        graphicColony = graphicColony.filter{$0 != aCell}
        return "(\(xCoor), \(yCoor))"
    }
    
}


