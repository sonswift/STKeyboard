//
//  View.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit

class View: UIView {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  init() {
    super.init(frame: CGRect.zero)
    self.commonInit()
    self.initView()
  }

  func commonInit() {
  }

  func initView() {
    self.backgroundColor = UIColor.clear
  }

  deinit {
    print("Deinit: View")
  }
}
