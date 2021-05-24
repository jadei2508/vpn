//
//  BasicAnimationInstance.swift
//  vpn
//
//  Created by Roman Alikevich on 24.05.2021.
//

import Foundation

enum BasicAnimationInstance: Float {
    case BASIC_ANIMATION_DURATION = 4.0
    case BASIC_ANIMATION_VALUE_FROM = 0.5
    case BASIC_ANIMATION_VALUE_TO = 2.0
}

enum BasicAnimationKeyPath {
    public static var INIT_BASIC_ANIMATION_KEY_PATH = "transform.scale"
    public static var SCALE_BASIC_ANIMATION_KEY_PATH = "scale"
    public static var OPACITY_BASIC_ANIMATION_KEY_PATH = "opacity"
}
