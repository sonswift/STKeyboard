//
//  AssetsLibrary.swift
//  Bubu
//
//  Created by Sơn Thái on 9/28/16.
//  Copyright © 2016 LOZI. All rights reserved.
//

import Photos
import UIKit

public protocol AssetsLibraryDelegate: class {
  func assetsLibraryGroupLoadingCompleted()
  func assetsLibraryGroupDidSelectGroup(_ imagesGroup: ImagesGroup)
}

fileprivate var currentPHImageRequestId: PHImageRequestID = -1

open class AssetsLibrary {

  fileprivate var imagesGroup: [ImagesGroup] = []

  open weak var delegate: AssetsLibraryDelegate?
  open var currentTitle: String = ""

  open func initGroup() {
    var tmpGroup: [ImagesGroup] = []
    let status = PHPhotoLibrary.authorizationStatus()
    if status == .authorized || status == .notDetermined {
      let cameraRolls = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
      _ = cameraRolls.enumerateObjects({ (collection, _, _) in
        let assets = PHAsset.fetchAssets(in: collection, options: nil)
        if assets.countOfAssets(with: .image) > 0 {
          let imageGroup = ImagesGroup()
          imageGroup.assetsCollection = collection
          tmpGroup.append(imageGroup)
        }
      })
      let allSmartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
      _ = allSmartAlbums.enumerateObjects({ (collection, _, _) in
        let assets = PHAsset.fetchAssets(in: collection, options: nil)
        if assets.countOfAssets(with: .image) > 0 {
          let imageGroup = ImagesGroup()
          imageGroup.assetsCollection = collection
          tmpGroup.append(imageGroup)
        }
      })
      let allAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
      _ = allAlbums.enumerateObjects({ (collection, _, _) in
        let assets = PHAsset.fetchAssets(in: collection, options: nil)
        if assets.countOfAssets(with: .image) > 0 {
          let imageGroup = ImagesGroup()
          imageGroup.assetsCollection = collection
          tmpGroup.append(imageGroup)
        }
      })

      self.imagesGroup = tmpGroup
      self.delegate?.assetsLibraryGroupLoadingCompleted()
    }
  }

  open func getImageOfCollection(index: Int, completionHandler handler: @escaping ([AssetModel]) -> Void, reverse: Bool) {
    if index > -1 && index < self.imagesGroup.count {
      let imagesGroup = self.imagesGroup[index]
      self.delegate?.assetsLibraryGroupDidSelectGroup(imagesGroup)
      if let collection = imagesGroup.assetsCollection, let name = collection.localizedTitle {
        self.currentTitle = name
      } else {
        self.currentTitle = ""
      }

      if !imagesGroup.phAssets.isEmpty {
        handler(imagesGroup.phAssets)
      } else {
        if let collection = imagesGroup.assetsCollection {
          var phCount = 0
          let assets = PHAsset.fetchAssets(in: collection, options: nil)
          assets.enumerateObjects({ (object, count, _) in
            let model = AssetModel()
            model.phAsset = object
            model.index = count
            phCount += 1
            if reverse {
              imagesGroup.phAssets.insert(model, at: 0)
            } else {
              imagesGroup.phAssets.append(model)
            }
          })
          handler(imagesGroup.phAssets)
        }
      }
    }
  }

  open func forceGetDefaultCollection(_ handler: @escaping ([AssetModel]) -> Void, reverse: Bool) {
    var index = -1

    for (i, imagesGroup) in self.imagesGroup.enumerated() {
      if let collection = imagesGroup.assetsCollection,
        collection.assetCollectionType == .smartAlbum,
        collection.assetCollectionSubtype == .smartAlbumUserLibrary {
        index = i
      }
    }
    if index > -1 && index < self.imagesGroup.count {
      let imagesGroup = self.imagesGroup[index]
      self.delegate?.assetsLibraryGroupDidSelectGroup(imagesGroup)
      if let collection = imagesGroup.assetsCollection, let name = collection.localizedTitle {
        self.currentTitle = name
      } else {
        self.currentTitle = ""
      }
      imagesGroup.phAssets.removeAll(keepingCapacity: false)
      if let collection = imagesGroup.assetsCollection {
        var phCount = 0
        let assets = PHAsset.fetchAssets(in: collection, options: nil)
        assets.enumerateObjects({ (object, count, _) in
          let model = AssetModel()
          model.phAsset = object
          model.index = count
          phCount += 1
          if reverse {
            imagesGroup.phAssets.insert(model, at: 0)
          } else {
            imagesGroup.phAssets.append(model)
          }
        })
        handler(imagesGroup.phAssets)
      }
    }
  }

  open func fetchDefaultPhAssetsWithReverse(_ reverse: Bool) {
    var index = -1
    for (i, imagesGroup) in self.imagesGroup.enumerated() {
      if let collection = imagesGroup.assetsCollection,
        collection.assetCollectionType == .smartAlbum,
        collection.assetCollectionSubtype == .smartAlbumUserLibrary {
        index = i
      }
    }
    if index > -1 && index < self.imagesGroup.count {
      let imagesGroup = self.imagesGroup[index]
      self.delegate?.assetsLibraryGroupDidSelectGroup(imagesGroup)
      if let collection = imagesGroup.assetsCollection, let name = collection.localizedTitle {
        self.currentTitle = name
      } else {
        self.currentTitle = ""
      }
      if imagesGroup.phAssets.isEmpty, let collection = imagesGroup.assetsCollection {
        var phCount = 0
        let assets = PHAsset.fetchAssets(in: collection, options: nil)
        assets.enumerateObjects({ (object, count, _) in
          let model = AssetModel()
          model.phAsset = object
          model.index = count
          phCount += 1
          if reverse {
            imagesGroup.phAssets.insert(model, at: 0)
          } else {
            imagesGroup.phAssets.append(model)
          }
        })
      }
    }
  }

  fileprivate func sort(_ order: String, reverse: Bool, array: [AssetModel]) -> [AssetModel] {
    if reverse {
      var sortArray: [AssetModel] = []
      let reverseArray = array.reversed()
      for (index, asset) in reverseArray.enumerated() {
        asset.index = index
        sortArray.append(asset)
      }
      return sortArray
    } else {
      return array
    }
  }

  open class func getThumnailImagePH(asset: PHAsset) -> UIImage? {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var thumbnail = UIImage()
    option.isSynchronous = true
    option.resizeMode = .fast
    manager.requestImage(for: asset, targetSize: CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2),
                         contentMode: .aspectFill, options: option, resultHandler: {(result, _) -> Void in
                          if let thumb = result {
                            thumbnail = thumb
                          }
    })
    return thumbnail
  }

  open class func getRatioThumbnailImagePH(asset: PHAsset) -> UIImage? {
    let manager = PHImageManager.default()
    let option = PHImageRequestOptions()
    var image = UIImage()
    option.isSynchronous = true
    option.resizeMode = .fast
    manager.requestImage(for: asset, targetSize: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width),
                         contentMode: .aspectFill, options: option, resultHandler: {(result, _) -> Void in
                          if let result = result {
                            image = result
                          }
    })
    return image
  }

  open class func getFullScreenImagePH(asset: PHAsset, completion: @escaping (UIImage?) -> Void) {
    let manager = PHImageManager.default()
    if currentPHImageRequestId != -1 {
      manager.cancelImageRequest(currentPHImageRequestId)
    }
    let option = PHImageRequestOptions()
    option.isNetworkAccessAllowed = true
    currentPHImageRequestId = manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize,
                                                   contentMode: .aspectFill, options: option,
                                                   resultHandler: {(result, info) -> Void in
                                                    guard let id = info?["PHImageResultRequestIDKey"] as? PHImageRequestID,
                                                      id == currentPHImageRequestId else { return }

                                                    completion(result)
    })
  }

  open func countImageInGroup(index: Int) -> Int {
    let imageGroup = self.imagesGroup[index]
    return imageGroup.assets.count
  }

  open func getImagesGroups() -> [ImagesGroup] {
    return self.imagesGroup
  }

  deinit {
    print("Deinit: AssetsLibrary")
  }
}
