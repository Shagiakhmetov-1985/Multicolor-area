//
//  StartScreenViewController.swift
//  Multicolor area
//
//  Created by Marat Shagiakhmetov on 09.04.2021.
//

import UIKit

protocol SettingMulticolorViewController {
    func setColorValue(_ color: UIColor)
}

class StartScreenViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? MulticolorViewController else { return }
        settingsVC.currentColor = view.backgroundColor
        settingsVC.delegate = self
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
    
}

// MARK: - Class from protocol
extension StartScreenViewController: SettingMulticolorViewController {
    func setColorValue(_ color: UIColor) {
        view.backgroundColor = color
    }
}
