//
//  STKeyboardPhotoCollection.swift
//  Bubu
//
//  Created by Sơn Thái on 9/28/16.
//  Copyright © 2016 LOZI. All rights reserved.
//

import AssetsLibrary
import UIKit

class STKeyboardPhotoCollection: UICollectionView {

  fileprivate let assetsLibrary = AssetsLibrary()
  internal var collectionLayout: UICollectionViewLayout?
  internal var fullSources: [AssetModel] = []
  internal var imageSources: [AssetModel] = []
  internal var location: Int = 0
  internal var length: Int = 10

  fileprivate var lastSelectedIndex: IndexPath?

  convenience init() {
    self.init(frame: CGRect.zero)
  }

  convenience init(frame: CGRect) {
    let size: CGFloat = STKeyboard.STKeyboardDefaultHeight - 4
    let collectionLayout = UICollectionViewFlowLayout()
    collectionLayout.itemSize = CGSize(width: size, height: size)
    collectionLayout.scrollDirection = .horizontal
    collectionLayout.minimumInteritemSpacing = 0
    collectionLayout.minimumLineSpacing = 2
    collectionLayout.sectionInset = UIEdgeInsets.zero
    self.init(frame: frame, collectionViewLayout: collectionLayout)
  }

  // Init collection with frame.
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    self.collectionLayout = layout
    self.commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func commonInit() {
    self.delegate = self
    self.dataSource = self
    self.showsHorizontalScrollIndicator = false
    self.showsVerticalScrollIndicator = false
    self.isPagingEnabled = false
    self.backgroundColor = UIColor.clear
    self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: STKeyboard.STKeyboardDefaultHeight)
    self.register(STKeyboardPhotoCollectionCell.self, forCellWithReuseIdentifier: "STKeyboardPhotoCollectionCell")
    self.contentInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    self.assetsLibrary.delegate = self
    self.assetsLibrary.initGroup()
  }

  func fetchDefaultAssetsGroup() {
    Threading.asyncBackground {
      self.assetsLibrary.fetchDefaultPhAssetsWithReverse(true)
    }
  }

  func getDefaultAssetsGroup() {
    Threading.asyncBackground {
      self.assetsLibrary.forceGetDefaultCollection({ (assets) -> Void in
        self.processResources(assets)
        self.loadDataFromFullSources(location: self.location, length: self.length)
        DispatchQueue.main.async {
          self.reloadData()
        }
      }, reverse: true)
    }
  }

  func processResources(_ assets: [AssetModel]) {
    self.fullSources.removeAll(keepingCapacity: false)
    self.fullSources.append(contentsOf: assets)
  }

  func loadDataFromFullSources(location: Int, length: Int) {
    var sourceLen = length
    if sourceLen + location > self.fullSources.count {
      sourceLen = fullSources.count - location
    }
    if sourceLen >= 0 && location >= 0, location + sourceLen > location {
      self.imageSources = Array(self.fullSources[location...(location + sourceLen - 1)])
    }
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension STKeyboardPhotoCollection: UICollectionViewDelegate, UICollectionViewDataSource {

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "STKeyboardPhotoCollectionCell", for: indexPath)
    if let photoCell = cell as? STKeyboardPhotoCollectionCell {
      let asset = self.imageSources[indexPath.row]
      photoCell.asset = asset
    }
    return cell
  }

  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.imageSources.count
  }

  public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    (self.getModel(at: indexPath) as? AssetModel)?.isSelected = false
  }

  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let lastSelectedIndex = self.lastSelectedIndex, lastSelectedIndex == indexPath else {
      (self.getModel(at: indexPath) as? AssetModel)?.isSelected = true
      self.lastSelectedIndex = indexPath
      return
    }

    self.deselectItem(at: indexPath, animated: true)
    self.lastSelectedIndex = nil
  }

  public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      let contentOffseX = self.contentOffset.x + self.contentInset.left
      if contentOffseX > scrollView.contentSize.width - scrollView.bounds.size.width * 1.5 {
        self.length += 10
        if self.length > self.fullSources.count {
          self.length = self.fullSources.count
        }
        Threading.asyncBackground {
          self.loadDataFromFullSources(location: self.location, length: self.length)
          DispatchQueue.main.async {
            self.reloadData()
          }
        }
      }
    }
  }

  public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
    let contentOffseX = self.contentOffset.x + self.contentInset.left
    if contentOffseX > scrollView.contentSize.width - scrollView.bounds.size.width * 1.5 {
      self.length += 10
      if self.length > self.fullSources.count {
        self.length = self.fullSources.count
      }
      Threading.asyncBackground {
        self.loadDataFromFullSources(location: self.location, length: self.length)
        DispatchQueue.main.async {
          self.reloadData()
        }
      }
    }
  }

  fileprivate func getModel(at indexPath: IndexPath) -> Model? {
    guard !self.imageSources.isEmpty && indexPath.row >= 0 && indexPath.row < self.imageSources.count else { return nil }

    return self.imageSources[indexPath.row]
  }
}

// MARK: - AssetsLibraryDelegate
extension STKeyboardPhotoCollection: AssetsLibraryDelegate {

  public func assetsLibraryGroupLoadingCompleted() {
    Threading.asyncBackground {
      self.assetsLibrary.forceGetDefaultCollection({ (assets) -> Void in
        self.processResources(assets)
        self.loadDataFromFullSources(location: self.location, length: self.length)
        DispatchQueue.main.async {
          self.reloadData()
        }
      }, reverse: true)
    }
  }

  public func assetsLibraryGroupDidSelectGroup(_ imagesGroup: ImagesGroup) {
  }
}
