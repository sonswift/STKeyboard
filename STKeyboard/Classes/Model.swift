//
//  Model.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit
import Photos

open class Model: NSObject {

  override init() {
    super.init()
    self.commonInit()
  }

  func commonInit() {
  }
}

open class AssetModel: Model {

  open var index: Int = -1

  open var phAsset: PHAsset!

  open var cropImage: UIImage?

  open var blurImage: UIImage?

  open var isSelected: Bool = false

  override func commonInit() {
    super.commonInit()
    self.phAsset = PHAsset()
  }
}

open class ImagesGroup: Model {

  open var assets: [AssetModel] = []

  open var phAssets: [AssetModel] = []

  open var assetsCollection: PHAssetCollection?
}
