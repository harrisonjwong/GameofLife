//
//  DetailViewController.swift
//  GameofLife-iPad2
//
//  Created by Alex Cao & Harrison Wong on 12/02/2016.
//  Copyright © 2016 Alex Cao & Harrison Wong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var speedSlider: UISlider!
    @IBOutlet var colonyView: ColonyView!
    @IBOutlet var wrappingSwitch: UISwitch!
    @IBOutlet var coorLabel: UILabel!
    
    var detailItem: Colony! {
        didSet {
            navigationItem.title = "Generation #\(detailItem.getGenerationNum())"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    
    //colonyview stuff
    var timer = NSTimer()
    var increment = Double()
    var timerOn = Bool()
    
    func configureView() {
        // Update the user interface for the detail item.
        if let colony = self.detailItem {
            if let view = self.colonyView {
                view.colony = colony
                timerOn = false
                wrappingSwitch.addTarget(self, action: #selector(DetailViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
                increment = Double(3 - speedSlider.value)
//                print("ViewController Loaded its view")
                view.updateGraphic()
//                print(detailItem.aliveCells)
//                print(view.graphicColony)
            }
        }
    }
    
    @IBAction func speedChanged(sender: AnyObject) {
        if speedSlider.value == speedSlider.minimumValue {
            timer.invalidate()
            timerOn = false
        } else {
            if !timerOn {
                increment = Double(3 - speedSlider.value)
                timer = NSTimer.scheduledTimerWithTimeInterval(increment, target: self, selector: #selector(DetailViewController.updateEvolve(_:)), userInfo: nil, repeats: true)
                timerOn = true
            } else {
                increment = Double(3 - speedSlider.value)
                timer.invalidate()
                timer = NSTimer.scheduledTimerWithTimeInterval(increment, target: self, selector: #selector(DetailViewController.updateEvolve(_:)), userInfo: nil, repeats: true)
//                print("timer on")
            }
        }
    }
    
    
    @objc func updateEvolve(t:NSTimer!) {
//        print(#function)
        if let colony = self.detailItem {
            if let view = self.colonyView {
                view.colony = colony
                colony.evolve()
                navigationItem.title = "Generation #\(detailItem.getGenerationNum())"
                view.updateGraphic()
//                print(view.graphicColony)
            }
        }
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            colonyView.colony.wrapping = true
        } else {
            colonyView.colony.wrapping = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if detailItem != nil {
            
            let touch = touches.first!
            
            let location = touch.locationInView(colonyView)
            
            var recentCellLabel = ""
            
            if colonyView.makeFrame(colonyView.bounds).contains(location) {
                if colonyView.colony.isCellAlive(Cell(xCoor: colonyView.convertPixelToCoorX(location.x), yCoor: colonyView.convertPixelToCoorY(location.y))) {
                    recentCellLabel = colonyView.removeCell(colonyView.convertPixelToCoorX(location.x), yCoor: colonyView.convertPixelToCoorY(location.y))
                    
                    colonyView.graphicEdit = false
                } else {
                    recentCellLabel = colonyView.addCell(colonyView.convertPixelToCoorX(location.x), yCoor: colonyView.convertPixelToCoorY(location.y))
                    colonyView.graphicEdit = true
                }
            }
            if recentCellLabel == "" {
                coorLabel.text = "(-1, -1)"
            } else {
                coorLabel.text = recentCellLabel
            }
            colonyView.setNeedsDisplay()
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if detailItem != nil {
            let touch = touches.first!
            
            let location = touch.locationInView(colonyView)
            
            var recentCellLabel = ""
            
            if colonyView.makeFrame(colonyView.bounds).contains(location) {
                if !colonyView.graphicEdit {
                    recentCellLabel = colonyView.removeCell(colonyView.convertPixelToCoorX(location.x), yCoor: colonyView.convertPixelToCoorY(location.y))
                } else {
                    recentCellLabel = colonyView.addCell(colonyView.convertPixelToCoorX(location.x), yCoor: colonyView.convertPixelToCoorY(location.y))
                }
            }
            if recentCellLabel == "" {
                coorLabel.text = "(-1, -1)"
            } else {
                coorLabel.text = recentCellLabel
            }
            colonyView.setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if detailItem != nil {
            colonyView.graphicEdit = true
        }
    }
    
    
}

