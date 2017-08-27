//
//  StarExposureTimeViewModel.swift
//  PhotographyKit
//
//  Created by peerapat atawatana on 5/15/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Action
import RxSwift

enum FiveHundredRuleViewModelError: Error {
  case `default`
}

protocol FiveHundredRuleViewModelType {
  var sensorCropTypes: Variable<[SensorCrop]> { get }
  
  func onCalculate500Rule() -> Action<(focalLength:Float, cropFactor:Float), Float>
}

class FiveHundredRuleViewModel: FiveHundredRuleViewModelType {
  
  var sensorCropTypes = Variable<[SensorCrop]>([])
  
  init(sensorCropTypes:[SensorCrop]) {
    self.sensorCropTypes.value = sensorCropTypes
  }
  
  func onCalculate500Rule() -> Action<(focalLength:Float, cropFactor:Float), Float> {
    return Action { (focalLength,cropFactor) in
      return Observable.create({ (observer) -> Disposable in
        guard cropFactor != 0, focalLength != 0 else {
          observer.onError(FiveHundredRuleViewModelError.default); return  Disposables.create()
        }
        observer.on(.next((500.0/focalLength)/cropFactor))
        observer.on(.completed)
        return Disposables.create()
      })
    }
  }
  
}
