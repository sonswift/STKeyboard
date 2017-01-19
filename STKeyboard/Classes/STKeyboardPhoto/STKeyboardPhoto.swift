//
//  STKeyboardPhoto.swift
//  Bubu
//
//  Created by Sơn Thái on 9/28/16.
//  Copyright © 2016 LOZI. All rights reserved.
//

import UIKit

class STKeyboardPhoto: STKeyboard {

  static let sharedPhoto = STKeyboardPhoto()
  fileprivate let collection = STKeyboardPhotoCollection()

  override func commonInit() {
    super.commonInit()
    self.backgroundColor = UIColor.commonWhiteSand
    self.addSubview(self.collection)
  }

  func initData() {
  }

  func fetchDefaultAssetsGroup() {
    self.collection.fetchDefaultAssetsGroup()
  }

  func getDefaultAssetsGroup() {
    self.collection.getDefaultAssetsGroup()
  }
}
