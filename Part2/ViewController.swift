//
//  ViewController.swift
//  Part2
//
//  Created by 山本ののか on 2020/07/19.
//  Copyright © 2020 Nonoka Yamamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var textField1: UITextField!
    @IBOutlet private weak var textField2: UITextField!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField1.becomeFirstResponder()
        answerLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction private func showTheAnswer(_ sender: Any) {
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



// 改善点

// 四捨五入する場合
//String(format: "%.2f", doubleNum1 / doubleNum2)
// 四捨五入しない場合
//String(format: "%.2f", floor(doubleNum1 / doubleNum2 * 100) / 100)

// 解答例

// 方法1
//switch segmentedControl.selectedSegmentIndex, doubleNum2 {
//case (0, _):
//    answerLabel.text = "\(intNum1 + intNum2)"
//case (1, _):
//    answerLabel.text = "\(intNum1 - intNum2)"
//case (2, _):
//    answerLabel.text = "\(intNum1 * intNum2)"
//case (3, 0):
//    answerLabel.text = "割る数には0以外を入力してください"
//case (3, _):
//    answerLabel.text = "\(intNum1 / intNum2)"
//    }
//default:
//    fatalError("計算できません")
//}

// 方法2
// これだとswitch文のdefaultが無くなる
// enum Operation: Int {
//     case addition
//     case subtraction
//     case multiplication
//     case division
//     init?(selectedSegmentIndex: Int) {
//         switch selectedSegmentIndex {
//         case 0:
//             self = .addition
//         case 1:
//             self = .subtraction
//         case 2:
//             self = .multiplication
//         case 3:
//             self = .division
//         default:
//             return nil
//         }
//     }
// }
// @IBOutlet private weak var textField1: UITextField!
// @IBOutlet private weak var textField2: UITextField!
// @IBOutlet private weak var segment: UISegmentedControl!
// @IBOutlet private weak var label: UILabel!
// @IBAction private func button(_ sender: Any) {
//     guard let operation = Operation(rawValue: segment.selectedSegmentIndex) else {
//         print("segment.selectedSegmentIndex is invalid.")
//         return
//     }
//     // isEmpty を使うと意図がより明確になる
//     guard !textField1.text!.isEmpty, !textField2.text!.isEmpty else {
//         label.text = "未入力の項目があります"
//         return
//     }
//     guard let value1 = Int(textField1.text!), let value2 = Int(textField2.text!) else {
//         label.text = "数字を入力してください"
//         return
//     }
//     switch operation {
//     case .addition:
//         label.text = "\(value1 + value2)"
//     case .subtraction:
//         label.text = "\(value1 - value2)"
//     case .multiplication:
//         label.text = "\(value1 * value2)"
//     case .division:
//         guard value1 != 0 && value2 != 0 else {
//             label.text = "割る数には0以外を入力してください"
//             return
//         }
//         label.text = "\(Double(value1) / Double(value2))"
//     }
// }

// 参考
//let nums = [self.textField1, self.textField2].map{Int($0.text ?? "") ?? 0}
