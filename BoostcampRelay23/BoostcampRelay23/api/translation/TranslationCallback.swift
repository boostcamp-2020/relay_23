//
//  TranslantionCallbackProtocol.swift
//  BoostcampRelay23
//
//  Created by Seungeon Kim on 2020/08/08.
//  Copyright © 2020 Boostcamp challenge. All rights reserved.
//

import Foundation

protocol TranslationCallback {
    func translationCallback(message: String) -> String {
        return message
    }
}
