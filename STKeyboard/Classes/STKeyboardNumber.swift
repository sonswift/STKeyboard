//
//  STKeyboardMoney.swift
//  Bubu
//
//  Created by Sơn Thái on 9/27/16.
//  Copyright © 2016 LOZI. All rights reserved.
//

import UIKit

class STKeyboardNumber: STKeyboard {

  static let sharedNumber = STKeyboardNumber()
  fileprivate var buttons: [STButton] = []

  override func commonInit() {
    super.commonInit()
    self.backgroundColor = UIColor.commonWhiteSand

    let padding: CGFloat = 1.0
    let width: CGFloat = (UIScreen.main.bounds.width - padding * 3) * 1/3
    let height: CGFloat = (STKeyboard.STKeyboardDefaultHeight - padding * 5) * 0.25
    var numberX: CGFloat = 0
    var numberY: CGFloat = padding

    for i in 0..<9 {
      let frame = CGRect(x: numberX, y: numberY, width: width, height: height)
      let button = self.createButton(title: "\(i + 1)", tag: i + 1, frame: frame)
      self.addSubview(button)
      self.buttons.append(button)

      numberX += (width + padding)
      if (i + 1) % 3 == 0 {
        numberX = 0.0
        numberY += (height + padding)
      }
    }

    let zeroFrame = CGRect(x: 0, y: STKeyboard.STKeyboardDefaultHeight - height - padding, width: width, height: height)
    let zero = self.createButton(title: "0", tag: 0, frame: zeroFrame)
    self.addSubview(zero)
    self.buttons.append(zero)

    let trippleFrame = CGRect(x: width + padding, y: STKeyboard.STKeyboardDefaultHeight - height - padding, width: width, height: height)
    let tripplezero = self.createButton(title: "000", tag: 11, frame: trippleFrame, titleSize: 20)
    self.addSubview(tripplezero)
    self.buttons.append(tripplezero)

    let backFrame = CGRect(x: UIScreen.main.bounds.width - width, y: STKeyboard.STKeyboardDefaultHeight - height - padding, width: width, height: height)
    let backSpace = self.createButton(title: "\u{232B}", tag: -1, frame: backFrame)
    self.addSubview(backSpace)
  }

  func numberTD(_ button: UIButton) {
    UIDevice.current.playInputClick()
    switch button.tag {
    case -1:
      self.backSpaceTD()
      break
    case 11:
      self.inputText(text: "000")
      break
    default:
      self.inputText(text: "\(button.tag)")
      break
    }
  }

  fileprivate func createButton(title: String, tag: Int, frame: CGRect, titleSize: CGFloat = 25) -> STButton {
    let button = STButton()
    button._normalBackgroundColor = UIColor.white
    button._selectedBackgroundColor = UIColor(hex: 0x535353)
    button.frame = frame
    button.setTitleColor(UIColor.black, for: .normal)
    button.setTitleColor(UIColor.white, for: .highlighted)
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: titleSize)
    button.tag = tag
    button.addTarget(self, action: #selector(STKeyboardNumber.numberTD(_:)), for: .touchDown)
    button.layer.cornerRadius = 5

    return button
  }
}
