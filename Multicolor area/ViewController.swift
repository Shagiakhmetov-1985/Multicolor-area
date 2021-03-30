//
//  ViewController.swift
//  Multicolor area
//
//  Created by Marat on 27.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var multiViewColor: UIView!
    
    @IBOutlet weak var labelRedColor: UILabel!
    @IBOutlet weak var labelGreenColor: UILabel!
    @IBOutlet weak var labelBlueColor: UILabel!
    
    @IBOutlet weak var sliderRedColor: UISlider!
    @IBOutlet weak var sliderGreenColor: UISlider!
    @IBOutlet weak var sliderBlueColor: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View
        multiViewColor.layer.cornerRadius = 15
        setColor()
        setValue(for: labelRedColor, labelGreenColor, labelBlueColor)
        
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
        case sliderGreenColor:
            setValue(for: labelGreenColor)
        default:
            setValue(for: labelBlueColor)
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
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

