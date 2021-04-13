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
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View
        multiViewColor.layer.cornerRadius = 15
        multiViewColor.backgroundColor = currentColor
        setSliders()
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
        delegate?.setColorValue(multiViewColor.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    // MARK: - Setup color on multiViewColor, private methods
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
    // MARK: Set sliders from start screen
    private func setSliders() {
        let ciColor = CIColor(color: currentColor)
        
        sliderRedColor.value = Float(ciColor.red)
        sliderGreenColor.value = Float(ciColor.green)
        sliderBlueColor.value = Float(ciColor.blue)
    }
    // MARK: Tap Done button
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    // MARK: Alert message
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Work with keyboard and text fields, UITextFieldDelegate
extension MulticolorViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        //guard let numberValue = Float(newValue) else { return }
        
        if let numberValue = Float(newValue) {
            switch textField {
            case redColorTextField:
                sliderRedColor.setValue(numberValue, animated: true)
                rgbSlider(sliderRedColor)
            case greenColorTextField:
                sliderGreenColor.setValue(numberValue, animated: true)
                rgbSlider(sliderGreenColor)
            default:
                sliderBlueColor.setValue(numberValue, animated: true)
                rgbSlider(sliderBlueColor)
            }
            return
        }
        
        showAlert(title: "Wrong format!", message: "Please enter correct value")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolbar = UIToolbar()
        textField.inputAccessoryView = keyboardToolbar
        keyboardToolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title:"Done",
            style: .done,
            target: self,
            action: #selector(didTapDone)
        )
        
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyboardToolbar.items = [flexBarButton, doneButton]
    }
}
