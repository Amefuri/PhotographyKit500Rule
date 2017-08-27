//
//  StarExposureTime.swift
//  PhotographyKit
//
//  Created by peerapat atawatana on 5/15/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import UIKit
import RxSwift
import Action
import RxCocoa

class FiveHundredRuleViewController: UIViewController {
    
    // MARK: Property
  
  let disposeBag = DisposeBag()
  var viewModel:FiveHundredRuleViewModelType = FiveHundredRuleViewModel(sensorCropTypes: [ .APSC,
                                                                                           .FullFrame,
                                                                                           .MicroFourThirds,
                                                                                           .OneInch,
                                                                                           .Custom(title: "",
                                                                                                   cropFactor: 1.0) ]) //TODO injection
  var currentSelectedSensorCropIndex = 0
  
  // MARK: IBOutlet
    
  @IBOutlet weak var sensorCropPickerView: UIPickerView!
  @IBOutlet weak var customSensorTitleLabel: UILabel!
  @IBOutlet weak var customSensorCropTextField: UITextField!
  @IBOutlet weak var focalLengthTextField: UITextField!
  @IBOutlet weak var resultTimeLabel: UILabel!
  @IBOutlet weak var actionButton: UIButton!
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPickerView()
    bindViewModel()
  }
  
  func bindViewModel() {
    
    // Bind PickerView: DidSelect

    sensorCropPickerView.rx.itemSelected.subscribe(onNext: {[unowned self] (row, _) in
      self.currentSelectedSensorCropIndex = row
      if case .Custom(_, let cropFactor) = self.viewModel.sensorCropTypes.value[self.currentSelectedSensorCropIndex] {
        self.customSensorCropTextField.text = cropFactor.description
        self.customSensorCropTextField.isHidden = false
        self.customSensorTitleLabel.isHidden = false
      }
      else {
        self.customSensorCropTextField.isHidden = true
        self.customSensorTitleLabel.isHidden = true
      }
    })
    .disposed(by: disposeBag)
    
    // Bind Action: Calculate500Rule
    
    let calculate500RuleAction = viewModel.onCalculate500Rule()
    
    calculate500RuleAction.elements
      .asDriver(onErrorJustReturn: 0)
      .do(onNext: { print($0)})
      .map({ "\(Int(ceil($0))) seconds" })
      .drive(resultTimeLabel.rx.text)
      .disposed(by: disposeBag)
    
    actionButton.rx.bind(to: calculate500RuleAction) {[unowned self] _ in
      let focalLength = Float(self.focalLengthTextField.text ?? "0") ?? 0.0
      let cropFactor  = self.viewModel.sensorCropTypes.value[self.currentSelectedSensorCropIndex].cropFactor
      return (focalLength, cropFactor)
    }
    
    // Subscribe changed of customSensor textfield
    
    customSensorCropTextField.rx.text
      .orEmpty
      .subscribe(onNext: {[unowned self] value in
        if case .Custom(_, _) = self.viewModel.sensorCropTypes.value[self.currentSelectedSensorCropIndex] {
          self.viewModel.sensorCropTypes.value[self.currentSelectedSensorCropIndex] = .Custom(title: "",
                                                                              cropFactor: Float(value) ?? 0)
      }
    }).disposed(by: disposeBag)
    
  }
  
  // MARK: Private
    
  func setupPickerView() {
    sensorCropPickerView.delegate = self
      sensorCropPickerView.dataSource = self
  }
}

