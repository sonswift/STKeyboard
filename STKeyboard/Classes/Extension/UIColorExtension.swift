//
//  UIColorExtension.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit

extension UIColor {

  open class var appBackground:               UIColor { return UIColor(hex: 0xe4e4e4) }
  open class var barBackground:               UIColor { return UIColor(hex: 0xf7f7f7) }
  open class var border:                      UIColor { return UIColor(hex: 0xafb4b6) }
  open class var facebookButton:              UIColor { return UIColor(hex: 0x295b84) }
  open class var magic:                       UIColor { return UIColor(hex: 0xed3554) }
  open class var lineBackground:              UIColor { return UIColor(hex: 0xeff0ef) }
  open class var selectedButton:              UIColor { return UIColor(hex: 0xd9d9d9) }
  open class var viewBackground:              UIColor { return UIColor(hex: 0xe4e4e4) }

  open class var commonRed:                   UIColor { return UIColor(hex: 0xed3554) }
  open class var commonDarkRed:               UIColor { return UIColor(hex: 0xed3445) }
  open class var commonExtremelyDarkRed:      UIColor { return UIColor(hex: 0xd0021b) }
  open class var commonSuperDarkRed:          UIColor { return UIColor(hex: 0xe10032) }
  open class var commonDarkBlue:              UIColor { return UIColor(hex: 0x295b84) }
  open class var commonShamock:               UIColor { return UIColor(hex: 0x2ce09e) }
  open class var commonLightGrey:             UIColor { return UIColor(hex: 0xafafb2) }
  open class var commonSuperLightGrey:        UIColor { return UIColor(hex: 0xf1f1f1) }
  open class var commonGrey:                  UIColor { return UIColor(hex: 0x424242) }
  open class var commonDarkGrey:              UIColor { return UIColor(hex: 0x4a4a4a) }
  open class var commonDaviGrey:              UIColor { return UIColor(hex: 0x535353) }
  open class var commonLightGreen:            UIColor { return UIColor(hex: 0x1bc82f) }
  open class var commonDarkGray:              UIColor { return UIColor(hex: 0x545454) }
  open class var commonGray:                  UIColor { return UIColor(hex: 0x9b9b9b) }
  open class var commonLightGray:             UIColor { return UIColor(hex: 0xdfdfdf) }
  open class var commonSuperLightGray:        UIColor { return UIColor(hex: 0xafafaf) }
  open class var commonExtremelyLightGray:    UIColor { return UIColor(hex: 0xf3f3f3) }
  open class var commonDarkWhite:             UIColor { return UIColor(hex: 0xfbfbfb) }
  open class var commonDarkConcrete:          UIColor { return UIColor(hex: 0xf6f6f6) }
  open class var commonConcrete:              UIColor { return UIColor(hex: 0xf5f5f5) }
  open class var commonLightConcrete:         UIColor { return UIColor(hex: 0xf5f5f5) }
  open class var commonOrange:                UIColor { return UIColor(hex: 0xf9a826) }
  open class var commonGreen:                 UIColor { return UIColor(hex: 0x1bc82f) }
  open class var commonMediumGreen:           UIColor { return UIColor(hex: 0x7ed321) }
  open class var commonBlue:                  UIColor { return UIColor(hex: 0x498ac0) }
  open class var commonLightBlue:             UIColor { return UIColor(hex: 0x4a90e2) }
  open class var commonSuperLightBlue:        UIColor { return UIColor(hex: 0x599dec) }
  open class var commonYellow:                UIColor { return UIColor(hex: 0xfad727) }
  open class var commonLightBlack:            UIColor { return UIColor(hex: 0x191919) }
  open class var commonSuperLightBlack:       UIColor { return UIColor(hex: 0x333333) }
  open class var commonWhiteSand:             UIColor { return UIColor(hex: 0xf4f4f4) }
  open class var commonMikadoYellow:          UIColor { return UIColor(hex: 0xffb300) }
  open class var commonWhiteSmoke:            UIColor { return UIColor(hex: 0xf2f2f2) }

  open class var commonTextGray:              UIColor { return UIColor(hex: 0xafb6b1) }

  open class var ratingBackgroundRed:         UIColor { return UIColor(hex: 0xdc1212) }
  open class var ratingBackgroundOrange:      UIColor { return UIColor(hex: 0xff9829) }
  open class var ratingBackgroundYellow:      UIColor { return UIColor(hex: 0xfad727) }
  open class var ratingBackgroundLightGreen:  UIColor { return UIColor(hex: 0x9dd81f) }
  open class var ratingBackgroundGreen:       UIColor { return UIColor(hex: 0x1bc82f) }

  open class var ratingLevel1: UIColor { return UIColor(hex: 0xd0021b) }
  open class var ratingLevel2: UIColor { return UIColor(hex: 0xf5a623) }
  open class var ratingLevel3: UIColor { return UIColor(hex: 0xf8e71c) }
  open class var ratingLevel4: UIColor { return UIColor(hex: 0x7ed321) }
  open class var ratingLevel5: UIColor { return UIColor(hex: 0x1bc82f) }

  open class var facebookColor: UIColor { return UIColor(hex: 0x3E6EC0) }

  convenience init(hex: Int, alpha: CGFloat = 1.0) {
    self.init(red: CGFloat((hex >> 16) & 0xff) / 255.0,
              green: CGFloat((hex >> 8) & 0xff) / 255.0,
              blue: CGFloat(hex & 0xff) / 255.0,
              alpha: alpha)
  }

  convenience init(hexString: String, alpha: CGFloat = 1.0) {
    if hexString.isEmpty || hexString.characters.count != 6 {
      self.init(hex: 0x498ac0) //Default color
    } else {
      var rgbValue: UInt32 = 0
      Scanner(string: hexString).scanHexInt32(&rgbValue)
      self.init(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
      )
    }
  }

  class func getRandomColor() -> UIColor {
    let r = arc4random() % 255 + 0
    let g = arc4random() % 255 + 0
    let b = arc4random() % 255 + 0

    return UIColor(red: CGFloat(r)/255.0,
                   green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
  }

  func alpha(_ alpha: CGFloat) -> UIColor {
    return self.withAlphaComponent(alpha)
  }

  func makeTouchState() -> UIColor {
    let percentage:CGFloat = 15.0
    return self.adjust(-1 * abs(percentage))
  }

  func adjust(_ percentage:CGFloat = 15.0) -> UIColor {
    var r:CGFloat = 0
    var g:CGFloat = 0
    var b:CGFloat = 0
    var a:CGFloat = 0
    if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
      return UIColor(red: min(r + percentage/100, 1.0),
                     green: min(g + percentage/100, 1.0),
                     blue: min(b + percentage/100, 1.0),
                     alpha: a)
    } else {
      return self
    }
  }
}
