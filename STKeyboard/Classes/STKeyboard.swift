//
//  STKeyboard.swift
//  Bubu
//
//  Created by Sơn Thái on 9/27/16.
//  Copyright © 2016 LOZI. All rights reserved.
//

import UIKit

public enum STKeyboardType {
  case `default`
  case number
  case photo
}

open class STKeyboard: UIView {

  static let STKeyboardDefaultHeight: CGFloat = 216

  open var textInput: UITextInput?

  fileprivate let backSpace = UIButton()

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init() {
    super.init(frame: CGRect.zero)
    self.commonInit()
  }

  open func commonInit() {
    self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: STKeyboard.STKeyboardDefaultHeight)
    self.backgroundColor = UIColor.white
  }

  open func hideKeyboardTUI() {
    if let textField = self.textInput as? UITextField, textField.canResignFirstResponder {
      textField.resignFirstResponder()
    }
    if let textView = self.textInput as? UITextView, textView.canResignFirstResponder {
      textView.resignFirstResponder()
    }
  }

  open func backSpaceTD() {
    UIDevice.current.playInputClick()
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(autoDelete), object: nil)
    self.canPerformAction(#selector(autoDelete), withSender: nil)
    if let textInput = self.textInput, let selectedTextRange = textInput.selectedTextRange {
      if selectedTextRange.isEmpty {
        textInput.deleteBackward()
      } else {
        self.replaceText(inRange: textInput.selectedTextRange, withText: "")
      }
    }
    self.perform(#selector(autoDelete),
                 with: nil,
                 afterDelay: 0.5,
                 inModes: [RunLoopMode.commonModes])
  }

  open func returnSpaceTUI() {
    UIDevice.current.playInputClick()
    if let textField = self.textInput as? UITextField {
      _ = textField.delegate?.textFieldShouldReturn?(textField)
    } else if let _ = self.textInput as? UITextView {
      self.inputText(text: "\n")
    }
  }

  open func autoDelete() {
    if self.backSpace.isHighlighted, let textInput = self.textInput {
      textInput.deleteBackward()
      self.perform(#selector(autoDelete),
                   with: nil,
                   afterDelay: 0.2,
                   inModes: [RunLoopMode.commonModes])
    }
  }

  /*
   * Input
   */
  open func setInputViewToView(_ view: UIView?) {
    (self.textInput as? UITextField)?.inputView = view
    (self.textInput as? UITextView)?.inputView = view
    (self.textInput as? UIResponder)?.reloadInputViews()
  }

  open func attachToTextInput(textInput: UITextInput) {
    self.textInput = textInput
    self.setInputViewToView(self)
  }

  open func switchToDefaultKeyboard() {
    self.setInputViewToView(nil)
    self.textInput = nil
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SwitchToDefaultKeyboard"), object: nil)
  }

  open func inputText(text: String) {
    if let textInput = self.textInput {
      self.replaceText(inRange: textInput.selectedTextRange, withText: text)
    }
  }

  open func replaceText(inRange range: UITextRange?, withText text: String) {
    if let range = range, self.textInputShouldReplaceText(inRange: range, replacementText: text) {
      self.textInput?.replace(range, withText: text)
    }
  }

  open func textInputShouldReplaceText(inRange range: UITextRange, replacementText text: String) -> Bool {
    if let textInput = self.textInput {
      let startOffset = textInput.offset(from: textInput.beginningOfDocument, to: range.start)
      let endOffset = textInput.offset(from: textInput.beginningOfDocument, to: range.end)
      let replacementRange = NSRange(location: startOffset, length: endOffset - startOffset)
      if let textView = textInput as? UITextView,
        let shouldChange = textView.delegate?.textView?(textView, shouldChangeTextIn: replacementRange, replacementText: text) {
        return shouldChange
      }
      if let textField = textInput as? UITextField,
        let shouldChange = textField.delegate?.textField?(textField, shouldChangeCharactersIn: replacementRange, replacementString: text) {
        return shouldChange
      }
    }
    return true
  }
}

