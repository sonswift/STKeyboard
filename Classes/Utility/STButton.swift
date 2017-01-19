//
//  STButton.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit

class STButton: UIButton {

  internal var _normalBackgroundColor: UIColor? = UIColor.clear { didSet { self.didSetNormalBackgroundColor() } }
  internal var _highlightedBackgroundColor: UIColor?
  internal var _selectedBackgroundColor: UIColor?

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init() {
    super.init(frame: CGRect.zero)
    self.commonInit()
  }

  fileprivate func commonInit() {
    self.backgroundColor = UIColor.clear
    self.adjustsImageWhenHighlighted = false
    self.adjustsImageWhenDisabled = false

    self.addTarget(self, action: #selector(STButton.touchDown), for: .touchDown)
    self.addTarget(self, action: #selector(STButton.touchUpInside), for: .touchUpInside)
    self.addTarget(self, action: #selector(STButton.touchUpOutside), for: .touchUpOutside)
    self.addTarget(self, action: #selector(STButton.touchDragOutside), for: .touchDragOutside)
    self.addTarget(self, action: #selector(STButton.touchDragInside), for: .touchDragInside)
  }

  func didSetNormalBackgroundColor() {
    if let normalColor = self._normalBackgroundColor {
      self._highlightedBackgroundColor = normalColor.makeTouchState()
    }
    self.backgroundColor = self._normalBackgroundColor
  }

  func touchDown() {
    self.backgroundColor = self._backgroundColor(for: .highlighted)
    self.imageView?.image = self._image(for: .highlighted)
  }

  func touchUpInside() {
    self.backgroundColor = self._backgroundColor(for: .normal)
    self.imageView?.image = self._image(for: .normal)
  }

  func touchUpOutside() {
    self.backgroundColor = self._backgroundColor(for: .normal)
    self.imageView?.image = self._image(for: .normal)
  }

  func touchDragOutside() {
    self.backgroundColor = self._backgroundColor(for: .normal)
    self.imageView?.image = self._image(for: .normal)
  }

  func touchDragInside() {
    self.backgroundColor = self._backgroundColor(for: .highlighted)
    self.imageView?.image = self._image(for: .highlighted)
  }

  fileprivate func _backgroundColor(for state: UIControlState) -> UIColor? {
    if self.isSelected {
      return self._selectedBackgroundColor ?? self._normalBackgroundColor
    } else {
      if state == .highlighted {
        return self._highlightedBackgroundColor ?? self._normalBackgroundColor
      }

      return self._normalBackgroundColor
    }
  }

  fileprivate func _image(for state: UIControlState) -> UIImage? {
    if self.isSelected {
      return self.image(for: .selected) ?? self.image(for: .normal)
    } else {
      return self.image(for: state) ?? self.image(for: .normal)
    }
  }

  deinit {
    print("Deinit: STButton")
  }
}
