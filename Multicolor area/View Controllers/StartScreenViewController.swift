//
//  StartScreenViewController.swift
//  Multicolor area
//
//  Created by Marat Shagiakhmetov on 09.04.2021.
//

import UIKit

protocol SettingMulticolorViewController {
    func setColorValue(setRed: CGFloat, setGreen: CGFloat, setBlue: CGFloat)
}

class StartScreenViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
    private var colorRed: CGFloat = 1
    private var colorGreen: CGFloat = 1
    private var colorBlue: CGFloat = 1
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? MulticolorViewController else { return }
        settingsVC.colorRedVC = colorRed
        settingsVC.colorGreenVC = colorGreen
        settingsVC.colorBlueVC = colorBlue
        settingsVC.delegate = self
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
    
}

// MARK: - Class from protocol
extension StartScreenViewController: SettingMulticolorViewController {
    func setColorValue(setRed: CGFloat, setGreen: CGFloat, setBlue: CGFloat) {
        mainView.backgroundColor = UIColor(red: setRed,
                                           green: setGreen,
                                           blue: setBlue,
                                           alpha: 1)
        colorRed = setRed
        colorGreen = setGreen
        colorBlue = setBlue
    }
}
