//
//  ViewController.swift
//  Calculator
//
//  Created by 하연 on 2017. 1. 22..
//  Copyright © 2017년 hayeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    
    //MARK: outlets
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var multipleButton: UIButton!
    @IBOutlet weak var divisionButton: UIButton!
    @IBOutlet weak var ansLabel: UILabel!
    @IBOutlet weak var firstAC: UIButton!
    @IBOutlet weak var secondAC: UIButton!
    
    var firstValue : Int?
    var secondValue : Int?

    // calculator type for calculate
    enum calculatorType : Int{
        case plus = 0, minus = 1, multiple = 2, division = 3
    }
    
    // button state for configure four button
    enum buttonState { case enable, disable }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.text = "0"
        secondTextField.text = "0"
        
        firstTextField.textAlignment = .center
        secondTextField.textAlignment = .center
        
        firstTextField.delegate = self
        secondTextField.delegate = self
        
        configureButton(.disable)

    }

    // MARK : Calculate
    
    // calculate resultValue using firstValue and secondValue
    @IBAction func calculate(_ sender: UIButton) {
        switch(calculatorType(rawValue: sender.tag)!) {
        case .plus:
            if let firstValue = firstValue, let secondValue = secondValue{
                let resultValue = firstValue + secondValue
                ansLabel.text = "\(resultValue)"
            }
        case .minus:
            if let firstValue = firstValue, let secondValue = secondValue{
                let resultValue = firstValue - secondValue
                ansLabel.text = "\(resultValue)"
            }
        case .multiple:
            if let firstValue = firstValue, let secondValue = secondValue{
                let resultValue = firstValue * secondValue
                ansLabel.text = "\(resultValue)"
            }
        case .division:
            if let firstValue = firstValue, let secondValue = secondValue{
                let resultValue = Double(firstValue) / Double(secondValue)
                ansLabel.text = "\(resultValue)"
            }
        }
    }
    
    // MARK : allClear button
    // When you click AC button, textField will be "0" and buttons will be disable
    @IBAction func allClear(_ sender: UIButton) {
        if sender == firstAC {
            firstTextField.text = "0"
            firstValue = 0
            configureButton(.disable)
        } else if sender == secondAC {
            secondTextField.text = "0"
            secondValue = 0
            configureButton(.disable)
        }
    }
    
    //MARK : configure Button
    
    func configureButton(_ buttonState: buttonState) {
        switch(buttonState) {
        case .enable:
            setButtonsEnabled(true)
            setButtonColor(UIColor.black)
        case .disable:
            setButtonsEnabled(false)
            setButtonColor(UIColor.gray)
            ansLabel.text = "Ans"
        }
    }
    
    func setButtonsEnabled(_ enabled: Bool) {
        plusButton.isEnabled = enabled
        minusButton.isEnabled = enabled
        multipleButton.isEnabled = enabled
        divisionButton.isEnabled = enabled

    }
    
    func setButtonColor(_ color:UIColor){
        plusButton.setTitleColor(color, for: .normal)
        minusButton.setTitleColor(color, for: .normal)
        multipleButton.setTitleColor(color, for: .normal)
        divisionButton.setTitleColor(color, for: .normal)
    }
    
    // MARK : textField
    
    // textField init
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //clear only when textField is 0
        if textField.text == "0"{
            if textField == firstTextField{
                firstTextField.text = ""
            }
            else if textField == secondTextField{
                secondTextField.text = ""
            }
        }
        
        //Arithmetic operation disable
        configureButton(.disable)

    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
    
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        let newString = newText as String
        
        //If the first value is 0, it is not accepted.
        if let firstInput = Int(newString){
            if firstInput == 0{
                return false
            }
        }
        
        //Save only numbers
        var value = ""
        let ar = Array(newString.characters)
        if ar.count > 0{
            for temp in ar{
                switch(temp){
                case "0","1","2","3","4","5","6","7","8","9":
                    value = value + String(temp)
                default :
                    print("It's not a number")
                }
                
            }
        }
        
        
        if textField == firstTextField{
            if let myInt = Int(value){
                firstValue = myInt
            }
        } else if textField == secondTextField{
            if let myInt = Int(value){
                secondValue = myInt

            }
        }

        //show only numbers
        return value == newString
    }
    
    //It can be calculated only when the values are not 0, nil.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if firstTextField.text != "0", secondTextField.text != "0", firstTextField.text != "", secondTextField.text != ""{
            configureButton(.enable)
        }

        return true
    }
   

}

