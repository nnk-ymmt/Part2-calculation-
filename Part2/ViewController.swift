//
//  ViewController.swift
//  Part2
//
//  Created by 山本ののか on 2020/07/19.
//  Copyright © 2020 Nonoka Yamamoto. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

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
//    answerLabel.text = "\(doubleNum1 + doubleNum2)"
//case (1, _):
//    answerLabel.text = "\(doubleNum1 - doubleNum2)"
//case (2, _):
//    answerLabel.text = "\(doubleNum1 * doubleNum2)"
//case (3, 0):
//    answerLabel.text = "割る数には0以外を入力してください"
//case (3, _):
//    answerLabel.text = "\(doubleNum1 / doubleNum2)"
//default:
//    fatalError("計算できません")
//}

// 方法2
// これだとswitch文のdefaultが無くなる
//enum Operation: Int {
//    case addition
//    case subtraction
//    case multiplication
//    case division
//
//    init?(selectedSegmentIndex: Int) {
//        switch selectedSegmentIndex {
//        case 0:
//            self = .addition
//        case 1:
//            self = .subtraction
//        case 2:
//            self = .multiplication
//        case 3:
//            self = .division
//        default:
//            return nil
//        }
//    }
//}
//
//@IBAction private func button(_ sender: Any) {
//    guard let operation = Operation(rawValue: segmentedControl.selectedSegmentIndex) else {
//        print("segment.selectedSegmentIndex is invalid.")
//        return
//    }
//    // isEmpty を使うと意図がより明確になる
//    guard !(textField1.text ?? "").isEmpty, !(textField2.text ?? "").isEmpty else {
//        answerLabel.text = "未入力の項目があります"
//        return
//    }
//    guard let value1 = Int(textField1.text ?? ""), let value2 = Int(textField2.text ?? "") else {
//        answerLabel.text = "数字を入力してください"
//        return
//    }
//    switch operation {
//    case .addition:
//        answerLabel.text = "\(value1 + value2)"
//    case .subtraction:
//        answerLabel.text = "\(value1 - value2)"
//    case .multiplication:
//        answerLabel.text = "\(value1 * value2)"
//    case .division:
//        guard value1 != 0 && value2 != 0 else {
//            answerLabel.text = "割る数には0以外を入力してください"
//            return
//        }
//        answerLabel.text = "\(Double(value1) / Double(value2))"
//    }
//}

// 方法3
// 2つの値の計算に関する責務のみ受け持つ
//enum Operator: Int {
//    case add
//    case subtract
//    case multiply
//    case devide
//
//    enum Error: Swift.Error {
//        case dividingByZero
//    }
//
//    func calculate(source: CalculatingSource) throws -> Int {
//        switch self {
//        case .add, .subtract, .multiply:
//            break
//        case .devide:
//            guard source.value2 != 0 else {
//                throw Error.dividingByZero
//            }
//        }
//        return ope(source.value1, source.value2)
//    }
//
//    private var ope: (Int, Int) -> Int {
//        switch self {
//        case .add:
//            return (+)
//        case .subtract:
//            return (-)
//        case .multiply:
//            return (*)
//        case .devide:
//            return (/)
//        }
//    }
//}
//
//final class ViewController: UIViewController {
//    @IBOutlet private var numTextFields: [UITextField]!
//    @IBOutlet private weak var resultCalcLabel: UILabel!
//    @IBOutlet private weak var operatorSegment: UISegmentedControl!
//
//    @IBAction func pressButton(_ sender: Any) {
//        guard let calculatingSource = InputNumberExtractor().extract(numTextFields: numTextFields) else {
//            resultCalcLabel.text = "各枠に数字（半角）を入力して下さい"
//            return
//        }
//
//        guard let ope = Operator(rawValue: operatorSegment.selectedSegmentIndex) else {
//            fatalError("selectedSegmentIndex is invalid.")
//        }
//
//        do {
//            resultCalcLabel.text = String(try ope.calculate(source: calculatingSource))
//        } catch Operator.Error.dividingByZero {
//            resultCalcLabel.text = "割る数には0以外を入力して下さい"
//        } catch {
//
//        }
//    }
//}
//
//// 計算で扱う2つの値を保持する責務のみ持つ
//struct CalculatingSource {
//    let value1: Int
//    let value2: Int
//}
//
//// textFieldsから2つの値を取り出すことに関する責務のみ持つ
//struct InputNumberExtractor {
//    func extract(numTextFields: [UITextField]) -> CalculatingSource? {
//        let numbers = numTextFields.map { $0.text ?? "" }.compactMap { Int($0) }
//        guard numbers.count == 2 else {
//            return nil
//        }
//        return CalculatingSource(value1: numbers[0], value2: numbers[1])
//    }
//}

// 参考
//let nums = [self.textField1, self.textField2].map{ Int($0.text ?? "") ?? 0 }
