//
//  MulticolorViewController.swift
//  Multicolor area
//
//  Created by Marat on 27.03.2021.
//

import UIKit

class MulticolorViewController: UIViewController {
    
    @IBOutlet weak var multiViewColor: UIView!
    
    @IBOutlet weak var labelRedColor: UILabel!
    @IBOutlet weak var labelGreenColor: UILabel!
    @IBOutlet weak var labelBlueColor: UILabel!
    
    @IBOutlet weak var sliderRedColor: UISlider!
    @IBOutlet weak var sliderGreenColor: UISlider!
    @IBOutlet weak var sliderBlueColor: UISlider!
    
    @IBOutlet weak var redColorTextField: UITextField!
    @IBOutlet weak var greenColorTextField: UITextField!
    @IBOutlet weak var blueColorTextField: UITextField!
    // MARK: - Public properties
    var delegate: SettingMulticolorViewController!
    
    var colorRedVC: CGFloat!
    var colorGreenVC: CGFloat!
    var colorBlueVC: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View
        multiViewColor.layer.cornerRadius = 15
        sliderRedColor.value = Float(colorRedVC)
        sliderGreenColor.value = Float(colorGreenVC)
        sliderBlueColor.value = Float(colorBlueVC)
        setColor()
        setValue(for: labelRedColor, labelGreenColor, labelBlueColor)
        setValueTextField(for: redColorTextField, greenColorTextField, blueColorTextField)
        
        //Sliders
        //Red
        sliderRedColor.minimumTrackTintColor = .red
        sliderRedColor.maximumTrackTintColor = .darkGray
        //Green
        sliderGreenColor.minimumTrackTintColor = .green
        sliderGreenColor.maximumTrackTintColor = .darkGray
        //Blue
        sliderBlueColor.minimumTrackTintColor = .blue
        sliderBlueColor.maximumTrackTintColor = .darkGray
        
        //Add done button on keyboard
        addDoneButtonOnKeyboard()
        
        //Text fields
        redColorTextField.delegate = self
        greenColorTextField.delegate = self
        blueColorTextField.delegate = self
    }
    // MARK: - Action sliders
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case sliderRedColor:
            setValue(for: labelRedColor)
            setValueTextField(for: redColorTextField)
        case sliderGreenColor:
            setValue(for: labelGreenColor)
            setValueTextField(for: greenColorTextField)
        default:
            setValue(for: labelBlueColor)
            setValueTextField(for: blueColorTextField)
        }
    }
    // MARK: Action button Done
    @IBAction func doneActionButton() {
        view.endEditing(true)
        delegate.setColorValue(setRed: CGFloat(sliderRedColor.value),
                               setGreen: CGFloat(sliderGreenColor.value),
                               setBlue: CGFloat(sliderBlueColor.value)
        )
        dismiss(animated: true)
    }
    // MARK: Setup color on multiViewColor
    private func setColor() {
        multiViewColor.backgroundColor = UIColor(
            red: CGFloat(sliderRedColor.value),
            green: CGFloat(sliderGreenColor.value),
            blue: CGFloat(sliderBlueColor.value),
            alpha: 1
        )
    }
    // MARK: Setup values on labels
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case labelRedColor:
                label.text = string(from: sliderRedColor)
            case labelGreenColor:
                label.text = string(from: sliderGreenColor)
            default:
                label.text = string(from: sliderBlueColor)
            }
        }
    }
    // MARK: Setup values on text fields
    private func setValueTextField(for textField: UITextField...) {
        textField.forEach { textField in
            switch textField {
            case redColorTextField:
                textField.text = string(from: sliderRedColor)
            case greenColorTextField:
                textField.text = string(from: sliderGreenColor)
            default:
                textField.text = string(from: sliderBlueColor)
            }
        }
    }
    // MARK: Setup value numbers
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

// MARK: - Work with keyboard and text fields
extension MulticolorViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolBar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0,
                                                                  y: 0,
                                                                  width: UIScreen.main.bounds.width,
                                                                  height: 50)
        )
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil
        )
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done",
                                                    style: .done,
                                                    target: self,
                                                    action: #selector(doneButtonAction)
        )
        
        let items = [flexSpace, done]
        doneToolBar.items = items
        doneToolBar.sizeToFit()
        
        redColorTextField.inputAccessoryView = doneToolBar
        greenColorTextField.inputAccessoryView = doneToolBar
        blueColorTextField.inputAccessoryView = doneToolBar
    }
    
    @objc func doneButtonAction() {
        redColorTextField.resignFirstResponder()
        greenColorTextField.resignFirstResponder()
        blueColorTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Float(newValue) else { return }
        
        switch textField {
        case redColorTextField:
            sliderRedColor.value = numberValue
            rgbSlider(sliderRedColor)
        case greenColorTextField:
            sliderGreenColor.value = numberValue
            rgbSlider(sliderGreenColor)
        default:
            sliderBlueColor.value = numberValue
            rgbSlider(sliderBlueColor)
        }
        
    }
}
