//
//  500RulePickerViewController.swift
//  PhotographyKit
//
//  Created by peerapat atawatana on 5/15/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit

extension FiveHundredRuleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.sensorCropTypes.value.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.sensorCropTypes.value[row].description
    }
}
