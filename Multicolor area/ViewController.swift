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
    
    private func setColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        multiViewColor.backgroundColor = .init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View
        multiViewColor.layer.cornerRadius = 15
        multiViewColor.backgroundColor = .init(red: CGFloat(sliderRedColor.value), green: CGFloat(sliderGreenColor.value), blue: CGFloat(sliderBlueColor.value), alpha: 1)
        
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
    
    @IBAction func sliderRedAction() {
        labelRedColor.text = String(format: "%.2f", sliderRedColor.value)
        setColor(red: CGFloat(sliderRedColor.value), green: CGFloat(sliderGreenColor.value), blue: CGFloat(sliderBlueColor.value))
    }
    
    @IBAction func sliderGreenAction() {
        labelGreenColor.text = String(format: "%.2f", sliderGreenColor.value)
        setColor(red: CGFloat(sliderRedColor.value), green: CGFloat(sliderGreenColor.value), blue: CGFloat(sliderBlueColor.value))
    }
    
    @IBAction func sliderBlueAction() {
        labelBlueColor.text = String(format: "%.2f", sliderBlueColor.value)
        setColor(red: CGFloat(sliderRedColor.value), green: CGFloat(sliderGreenColor.value), blue: CGFloat(sliderBlueColor.value))
    }

}

