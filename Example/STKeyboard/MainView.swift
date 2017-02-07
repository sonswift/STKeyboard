//
//  MainView.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit
import STKeyboard

class MainView: View {

  fileprivate let textField = UITextField()
  fileprivate let segment = UISegmentedControl(items: ["Normal", "Photo", "Number"])
  fileprivate let imageView = UIImageView()
  fileprivate let background = STButton()

  override func initView() {
    super.initView()
    self.frame = UIScreen.main.bounds
    NotificationCenter.default.addObserver(self, selector: #selector(didSelectImage(_:)),
                                           name: NSNotification.Name(rawValue: "PhotoKeyboardCollectionCellPickImage"), object: nil)

    self.background.frame = UIScreen.main.bounds
    self.background._normalBackgroundColor = UIColor.clear
    self.background.addTarget(self, action: #selector(backgroundTUI), for: .touchUpInside)

    self.textField.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 60, height: 34)
    self.textField.backgroundColor = UIColor.commonWhiteSand
    self.textField.layer.cornerRadius = 5
    self.textField.delegate = self

    self.segment.frame = CGRect(x: 30, y: self.textField.frame.maxY + 20, width: UIScreen.main.bounds.width - 60, height: 40)
    self.segment.addTarget(self, action: #selector(segmentDidChangeValue), for: UIControlEvents.valueChanged)

    self.imageView.frame = CGRect(x: UIScreen.main.bounds.midX - 50, y: self.segment.frame.maxY + 20, width: 100, height: 100)
    self.imageView.clipsToBounds = true
    self.imageView.contentMode = UIViewContentMode.scaleToFill
    self.imageView.layer.cornerRadius = 5
    self.imageView.backgroundColor = UIColor.commonWhiteSand

    self.addSubview(self.background)
    self.addSubview(self.textField)
    self.addSubview(self.segment)
    self.addSubview(self.imageView)
  }

  func segmentDidChangeValue() {
    self.clearImage()
    switch self.segment.selectedSegmentIndex {
    case 1:
      self.textField.switchToSTKeyboard(withType: .photo)
      break

    case 2:
      self.textField.switchToSTKeyboard(withType: .number)
      break

    default:
      self.textField.switchToSTKeyboard(withType: .default)
      break
    }

    // Begin editing
    _ = self.textField.becomeFirstResponder()
  }

  func backgroundTUI() {
    _ = self.textField.resignFirstResponder()
  }

  func didSelectImage(_ notification: Notification) {
    // Take image
    guard let img = notification.object as? UIImage else { return }

    let ratio: CGFloat = img.size.width / img.size.height
    if ratio > 1 {
      let width: CGFloat = min(150, img.size.width)
      let height: CGFloat = width * img.size.height / img.size.width
      self.imageView.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2, y: self.segment.frame.maxY + 20, width: width, height: height)
    } else {
      let height: CGFloat = min(150, img.size.height)
      let width: CGFloat = height * img.size.width / img.size.height
      self.imageView.frame = CGRect(x: UIScreen.main.bounds.midX - width / 2, y: self.segment.frame.maxY + 20, width: width, height: height)
    }

    self.imageView.image = img
  }

  fileprivate func clearImage() {
    self.imageView.frame = CGRect(x: UIScreen.main.bounds.midX - 50, y: self.segment.frame.maxY + 20, width: 100, height: 100)
    self.imageView.image = nil
  }
}

// MARK: - UITextFieldDelegate
extension MainView: UITextFieldDelegate {

  func textFieldDidBeginEditing(_ textField: UITextField) {
    if self.segment.selectedSegmentIndex < 0 {
      self.segment.selectedSegmentIndex = 0
    }
  }
}
