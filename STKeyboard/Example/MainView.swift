//
//  MainView.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit

class MainView: View {

  fileprivate let textField = UITextField()
  fileprivate let segment = UISegmentedControl(items: ["Normal", "Photo", "Number"])
  fileprivate let imageView = UIImageView()

  override func initView() {
    super.initView()
    self.frame = Constants.mainBounds
    NotificationCenter.default.addObserver(self, selector: #selector(didSelectImage(_:)),
                                           name: NSNotification.Name(rawValue: "PhotoKeyboardCollectionCellPickImage"), object: nil)

    self.textField.frame = CGRect(x: 30, y: 30, width: Constants.mainBounds.width - 60, height: 34)
    self.textField.backgroundColor = UIColor.commonWhiteSand
    self.textField.layer.cornerRadius = 5

    self.segment.frame = CGRect(x: 30, y: self.textField.frame.maxY + 20, width: Constants.mainBounds.width - 60, height: 40)
    self.segment.selectedSegmentIndex = 0
    self.segment.addTarget(self, action: #selector(segmentDidChangeValue), for: UIControlEvents.valueChanged)

    self.imageView.frame = CGRect(x: Constants.mainBounds.midX - 50, y: self.segment.frame.maxY + 20, width: 100, height: 100)
    self.imageView.clipsToBounds = true
    self.imageView.contentMode = UIViewContentMode.scaleToFill
    self.imageView.layer.cornerRadius = 5
    self.imageView.backgroundColor = UIColor.commonWhiteSand

    self.addSubview(self.textField)
    self.addSubview(self.segment)
    self.addSubview(self.imageView)
  }

  func segmentDidChangeValue() {
    self.imageView.image = nil
    switch self.segment.selectedSegmentIndex {
    case 1:
      self.textField.switchToSTKeyboard(withType: STKeyboardType.photo)
      break

    case 2:
      self.textField.switchToSTKeyboard(withType: STKeyboardType.number)
      break

    default:
      self.textField.switchToSTKeyboard(withType: STKeyboardType.default)
      break
    }
  }

  func didSelectImage(_ notification: Notification) {
    // Take image
    guard let asset = notification.object as? AssetModel else { return }

    AssetsLibrary.getFullScreenImagePH(asset: asset.phAsset) { (image) in
      guard let img = image else { return }

      let ratio: CGFloat = img.size.width / img.size.height
      if ratio > 1 {
        let width: CGFloat = min(150, img.size.width)
        let height: CGFloat = width * img.size.height / img.size.width
        self.imageView.frame = CGRect(x: Constants.mainBounds.midX - width / 2, y: self.segment.frame.maxY + 20, width: width, height: height)
      } else {
        let height: CGFloat = min(150, img.size.height)
        let width: CGFloat = height * img.size.width / img.size.height
        self.imageView.frame = CGRect(x: Constants.mainBounds.midX - width / 2, y: self.segment.frame.maxY + 20, width: width, height: height)
      }

      self.imageView.image = img
    }
  }

  fileprivate func clearImage() {
    self.imageView.frame = CGRect(x: Constants.mainBounds.midX - 50, y: self.segment.frame.maxY + 20, width: 100, height: 100)
    self.imageView.image = nil
  }
}
