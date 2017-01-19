//
//  ViewController.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    

  fileprivate let mainView = MainView()

  override func loadView() {
    super.loadView()
    self.view.backgroundColor = UIColor.white

    self.view.addSubview(self.mainView)
  }
}
