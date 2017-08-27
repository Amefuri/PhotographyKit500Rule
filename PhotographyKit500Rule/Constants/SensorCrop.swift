//
//  SensorCrop.swift
//  PhotographyKit
//
//  Created by peerapat atawatana on 5/15/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation

enum SensorCrop {
    case APSC
    case FullFrame
    case MicroFourThirds
    case OneInch
    case Custom(title:String, cropFactor:Float)
}

extension SensorCrop {
    public var title: String {
        switch self {
        case .APSC:
            return "APS-C"
        case .FullFrame:
            return "Full-Frame"
        case .MicroFourThirds:
            return "4/3"
        case .OneInch:
            return "1-inch"
        case .Custom(let title, _):
            return title
        }
    }
}

extension SensorCrop {
    public var cropFactor: Float {
        switch self {
        case .APSC:
            return 1.5
        case .FullFrame:
            return 1.0
        case .MicroFourThirds:
            return 2.0
        case .OneInch:
            return 2.72
        case .Custom(_, let cropFactor):
            return cropFactor
        }
    }
}

extension SensorCrop: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Custom(let title, _):
            return title != "" ? title : "Custom"
        default:
             return "\(title) (\(cropFactor))"
        }
    }
}

