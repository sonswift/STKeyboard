//
//  Threading.swift
//  STKeyboard
//
//  Created by Son on 1/19/17.
//  Copyright © 2017 Sonracle. All rights reserved.
//

import UIKit

infix operator ~>

/** Serial dispatch queue used by the ~> operator. */
private let queue = DispatchQueue(label: "serial-worker", attributes: [])
private let concurrent = DispatchQueue(label: "concurrent-worker", attributes: DispatchQueue.Attributes.concurrent)

/**
 Executes the lefthand closure on a background thread and,
 upon completion, the righthand closure on the main thread.
 Passes the background closure's output, if any, to the main closure.
 */
func ~> <R> (backgroundClosure: @escaping () -> R,
         mainClosure: @escaping (_ result: R) -> Void) {
  queue.async {
    let result = backgroundClosure()
    DispatchQueue.main.async(execute: {
      mainClosure(result)
    })
  }
}

class Threading {
  class func syncMain(_ block: @escaping () -> Void) {
    DispatchQueue.main.sync(execute: block)
  }

  class func asyncMain(_ block: @escaping () -> Void) {
    DispatchQueue.main.async(execute: block)
  }

  class func asyncBackground(_ background: @escaping () -> Void) {
    queue.async(execute: background)
  }

  class func syncBackground(_ background: @escaping () -> Void) {
    queue.sync(execute: background)
  }

  class func executeInBackground(_ backgroundBlock: @escaping () -> Void,
                                 inMain mainBlock: @escaping () -> Void) {
    {
      backgroundBlock()
      } ~> {
        mainBlock()
    }
  }

  class func executeConcurrent(_ block: @escaping () -> Void) {
    concurrent.async(execute: block)
  }

  class func delay(_ delayTime: Double, handler: @escaping (() -> Void)) {
    let delayTimeDispatch = DispatchTime.now() + Double(CLongLong(delayTime * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTimeDispatch) {
      handler()
    }
  }
}
