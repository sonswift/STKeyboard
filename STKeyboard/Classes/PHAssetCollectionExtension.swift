//
//  PHAssetCollectionExtension.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit
import Photos

public extension PHAssetCollection {

  open var photosCount: Int {
    let fetchOptions = PHFetchOptions()
    fetchOptions.predicate = NSPredicate(format: "mediaType == %d", PHAssetMediaType.image.rawValue)
    let result = PHAsset.fetchAssets(in: self, options: fetchOptions)
    return result.count
  }
}
