//
//  ViewController.swift
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View
        multiViewColor.layer.cornerRadius = 15
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
        
    }
    
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
    
    @IBAction func rgbTextField(_ sender: UITextField) {
        switch sender {
        case redColorTextField:
            let textField = Float(sender.text!)
            sliderRedColor.value = textField!
            rgbSlider(sliderRedColor)
        case greenColorTextField:
            let textField = Float(sender.text!)
            sliderGreenColor.value = textField!
            rgbSlider(sliderGreenColor)
        default:
            let textField = Float(sender.text!)
            sliderBlueColor.value = textField!
            rgbSlider(sliderBlueColor)
        }
    }
    
    private func setColor() {
        multiViewColor.backgroundColor = UIColor(
            red: CGFloat(sliderRedColor.value),
            green: CGFloat(sliderGreenColor.value),
            blue: CGFloat(sliderBlueColor.value),
            alpha: 1
        )
    }
    
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
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

// MARK: - Work with keyboard
extension MulticolorViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
