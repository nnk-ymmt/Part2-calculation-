//
//  ViewController.swift
//  Part2
//
//  Created by 山本ののか on 2020/07/19.
//  Copyright © 2020 Nonoka Yamamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField1: UITextField!
    @IBOutlet var textField2: UITextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField1.becomeFirstResponder()
        answerLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func showTheAnswer(_ sender: Any) {
        let doubleNum1 = Double(textField1.text ?? "") ?? 0
        let doubleNum2 = Double(textField2.text ?? "") ?? 0
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            answerLabel.text = String(doubleNum1 + doubleNum2)
        case 1:
            answerLabel.text = String(doubleNum1 - doubleNum2)
        case 2:
            answerLabel.text = String(doubleNum1 * doubleNum2)
        case 3:
            if doubleNum2 == 0 {
                answerLabel.text = "割る数には0以外を入力してください"
            } else {
                let answer = floor(doubleNum1 / doubleNum2 * 100)
                answerLabel.text = String(answer / 100)
            }
        default:
            return
        }
    }
}

