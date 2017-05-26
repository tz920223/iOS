//
//  ViewController.swift
//  MyCalcTong
//
//  Created by Tong Zhang on 3/30/17.
//  Copyright © 2017 Tong Zhang. All rights reserved.
//

import UIKit

enum modes {
    case not_set
    case addition
    case subtraction
    case multiplication
    case division
    case percentage
    case power
    
    case mod
    case root
}

class ViewController: UIViewController {
    
    @IBOutlet weak var outletLabel: UILabel!
    
    var outletLabelString:String = "0"
    var currentMode:modes = .not_set
    var savedNum:Double = 0
    var lastButtonWasMode:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressNumber(_ sender: UIButton) {
        let stringValue:String? = sender.titleLabel?.text
        
        if(lastButtonWasMode) {
            lastButtonWasMode = false
            outletLabelString = "0"
        }
        
        outletLabelString = outletLabelString.appending(stringValue!)
        updateText()
    }
    
    @IBAction func didPressPlus(_ sender: UIButton) {
        changeMode(newMode: .addition)
        
    }
    
    @IBAction func didPressMinus(_ sender: UIButton) {
        changeMode(newMode: .subtraction)
        
    }
    
    @IBAction func didPressMultiply(_ sender: UIButton) {
        changeMode(newMode: .multiplication)

    }
    
    @IBAction func didPressDivide(_ sender: UIButton) {
        changeMode(newMode: .division)

    }
    
    @IBAction func didPressPercent(_ sender: UIButton) {
        changeMode(newMode: .percentage)
        
    }


    @IBAction func didPressMod(_ sender: UIButton) {
        changeMode(newMode: .mod)
        
    }
    
    
    @IBAction func didPressRoot(_ sender: UIButton) {
        changeMode(newMode: .root)
        
    }
    

    @IBAction func didPressPower(_ sender: UIButton) {
        
        changeMode(newMode: .power)
        
        
    }
    
    @IBAction func didPressClear(_ sender: UIButton) {
        outletLabelString = "0"
        currentMode = .not_set
        savedNum = 0
        lastButtonWasMode = false
        outletLabel.text = "0"
        
    }
    
    @IBAction func didPressEqual(_ sender: UIButton) {
        print("pressed equals")
        
        
        let labelInt:Double = Double(outletLabelString)!
        
        if(currentMode == .not_set || lastButtonWasMode) {
            return
        }
        
        print("Mode: \(currentMode)")
        print("Label Int: \(labelInt)")
        print("Saved Num: \(savedNum)")
        
        if(currentMode == .addition) {
            savedNum += labelInt
        } else if (currentMode == .subtraction) {
            savedNum -= labelInt
        } else if (currentMode == .multiplication) {
            savedNum *= labelInt
        } else if (currentMode == .division) {
            savedNum /= labelInt
        } else if (currentMode == .percentage) {
            savedNum = (savedNum/100) * labelInt
        } else if (currentMode == .root) {
            savedNum = root(savedNum, labelInt)
        } else if (currentMode == .mod) {
            savedNum = Double(Int(savedNum) % Int(labelInt))
        } else if (currentMode == .power) {
            savedNum = power(savedNum, labelInt)
        }
        
        print("Saved Num: \(savedNum)")
        currentMode = .not_set
        outletLabelString = "\(savedNum)"
        updateText()
    }
    
    func root(_ x:Double, _ y:Double) -> Double {
        
        let result = pow(y, (1/x))
        
        return result
        
    }
    
    func power(_ x: Double, _ y:Double) -> Double {
        if y == 0 || y < 0 {
            return 1
        } else {
            return x * power(x, y-1)
        }
    }
    
    
    func updateText() {
        guard let labelInt:Double = Double(outletLabelString) else {
            return
        }

        if(currentMode == .not_set) {
            savedNum = Double(labelInt)
        }
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        let num:NSNumber = NSNumber(value:labelInt)
        
        
        outletLabel.adjustsFontSizeToFitWidth = true
        outletLabel.minimumScaleFactor = 0.5
        outletLabel.text = formatter.string(from: num)
    }
    
    func changeMode(newMode: modes) {
        if(savedNum == 0) {
            return
        }
        currentMode = newMode
        lastButtonWasMode = true
    }
    

}

