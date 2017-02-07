//
//  STKeyboardPhoto.swift
//  Bubu
//
//  Created by Sơn Thái on 9/28/16.
//  Copyright © 2016 LOZI. All rights reserved.
//

import UIKit

open class STKeyboardPhoto: STKeyboard {

  static let sharedPhoto = STKeyboardPhoto()
  fileprivate let collection = STKeyboardPhotoCollection()

  override open func commonInit() {
    super.commonInit()
    self.backgroundColor = UIColor.commonWhiteSand
    self.addSubview(self.collection)
  }

  open func initData() {
  }

  open func fetchDefaultAssetsGroup() {
    self.collection.fetchDefaultAssetsGroup()
  }

  open func getDefaultAssetsGroup() {
    self.collection.getDefaultAssetsGroup()
  }
}
