//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    //MARK: - IB Outlets
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    //MARK: - Public properites
    var valueForBlueSlider: Float!
    var valueForGreenSlider: Float!
    var valueForRedSlider: Float!
    
    var delegate: colorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
        
        redSlider.value = valueForRedSlider
        greenSlider.value = valueForGreenSlider
        blueSlider.value = valueForBlueSlider
        
        setColor()
        setValueLabels(for: redLabel,
                       greenLabel,
                       blueLabel)
    }
    //MARK: - IB Actions
    @IBAction func doneButtonPressed() {
        delegate?.getColor(redColor: redSlider.value,
                           greenColor: greenSlider.value,
                           blueColor: blueSlider.value)
        dismiss(animated: true)
    }
    
    // Изменение цветов слайдерами
    @IBAction func rgbSlider(_ sender: UISlider) {
        switch sender.tag {
        case 0: redLabel.text = string(from: sender)
            redTextField.text = string(from: sender)
        case 1: greenLabel.text = string(from: sender)
            greenTextField.text = string(from: sender)
        case 2: blueLabel.text = string(from: sender)
            blueTextField.text = string(from: sender)
        default: break
        }
        setColor()
    }
    
    //MARK: - Private Methods
    // Цвет вью
    private func setColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func setValueLabels(for labels: UILabel...) {
        labels.forEach { label in
            switch label.tag {
            case 0: redLabel.text = string(from: redSlider)
                redTextField.text = string(from: redSlider)
            case 1: greenLabel.text = string(from: greenSlider)
                greenTextField.text = string(from: greenSlider)
            case 2: blueLabel.text = string(from: blueSlider)
                blueTextField.text = string(from: blueSlider)
            default: break
            }
        }
    }
    
    // Значения RGB
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

extension UITextField {

   func addDoneButtonOnKeyboard() {
       let keyboardToolbar = UIToolbar()
       keyboardToolbar.sizeToFit()
       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
           target: nil, action: nil)
       let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
           target: self, action: #selector(resignFirstResponder))
       keyboardToolbar.items = [flexibleSpace, doneButton]
       self.inputAccessoryView = keyboardToolbar
   }
}


// MARK: - Text Fields Delegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case redTextField:
            textFieldDidEndEditing(redTextField, redLabel, redSlider)
            return true
        case greenTextField:
            textFieldDidEndEditing(greenTextField, greenLabel, greenSlider)
            return true
        case blueTextField:
            textFieldDidEndEditing(blueTextField, blueLabel, blueSlider)
            return true
        default: return false
        }
    }
    
    private func textFieldDidEndEditing(_ textfield: UITextField, _ label: UILabel, _ slider: UISlider) {
        
        if let text = textfield.text {
            if let number = Float(text) {
                slider.setValue(number, animated: true)
                setValueLabels(for: label)
                setColor()
                textfield.resignFirstResponder()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textFieldDidEndEditing(redTextField, redLabel, redSlider)
        textFieldDidEndEditing(greenTextField, greenLabel, greenSlider)
        textFieldDidEndEditing(blueTextField, blueLabel, blueSlider)
    }
}
