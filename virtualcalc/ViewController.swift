//
//  ViewController.swift
//  virtualcalc
//
//  Created by Florent on 20/12/2017.
//  Copyright © 2017 Florent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentValue: UILabel!
    @IBOutlet weak var resultValue: UILabel!
    
    private var storeOperateur = ""
    
    @IBAction func getChiffre(_ sender: UIButton) {
        if let chiffre = sender.title(for: .normal) {
            currentValue.text =   currentValue.text != "0"
                                ? currentValue.text! + chiffre
                                : chiffre
        }
    }
    
    @IBAction func operateur(_ sender: UIButton) {
        if let buttonLabel = sender.title(for: .normal) {
            
            if buttonLabel == "clear" {
                currentValue.text = "0"
                resultValue.text  = "0"
            } else {
                var calcul:Float = 0
                switch self.storeOperateur {
                    //case "+": calcul = Float(resultValue.text!)! + Float(currentValue.text!)!
                    case "-": calcul = Float(resultValue.text!)! - Float(currentValue.text!)!
                    case "*": calcul = Float(resultValue.text!)! * Float(currentValue.text!)!
                    case "/": calcul = Float(resultValue.text!)! / Float(currentValue.text!)!
                    default : calcul = Float(resultValue.text!)! + Float(currentValue.text!)!
                }

                resultValue.text  = calcul.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", calcul) : String(calcul)
                currentValue.text = "0"
                self.storeOperateur = buttonLabel
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        resultValue.text  = "0"
        currentValue.text = "0"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

