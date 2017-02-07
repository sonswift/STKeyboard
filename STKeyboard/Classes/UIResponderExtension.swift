//
//  STResponder.swift
//  Bubu
//
//  Created by Sơn Thái on 9/27/16.
//  Copyright © 2016 LOZI. All rights reserved.
//

import UIKit

public extension UIResponder {

  public func switchToSTKeyboard(withType type: STKeyboardType) {
    switch type {
    case .default:
      self.stKeyboard()?.switchToDefaultKeyboard()
      break
    case .number:
      self.switchToSTKeyboard(keyboard: STKeyboardNumber.sharedNumber)
      break
    case .photo:
      STKeyboardPhoto.sharedPhoto.getDefaultAssetsGroup()
      self.switchToSTKeyboard(keyboard: STKeyboardPhoto.sharedPhoto)
      break
    }
  }

  public func stKeyboard() -> STKeyboard? {
    if let keyboard = self.inputView as? STKeyboard {
      return keyboard
    }
    return nil
  }

  public func switchToSTKeyboard(keyboard: STKeyboard) {
    if let textInput = self as? UITextInput {
      keyboard.attachToTextInput(textInput: textInput)
    }
  }
}
