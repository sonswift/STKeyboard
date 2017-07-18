# STKeyboard

[![CI Status](http://img.shields.io/travis/son11592/STKeyboard.svg?style=flat)](https://travis-ci.org/son11592/STKeyboard)
[![Version](https://img.shields.io/cocoapods/v/STKeyboard.svg?style=flat)](http://cocoapods.org/pods/STKeyboard)
[![License](https://img.shields.io/cocoapods/l/STKeyboard.svg?style=flat)](http://cocoapods.org/pods/STKeyboard)
[![Platform](https://img.shields.io/cocoapods/p/STKeyboard.svg?style=flat)](http://cocoapods.org/pods/STKeyboard)


## Features
- [x] Support Photo keyboard. (Camera Roll || All Photos)
- [x] Support Number keyboard.
- [x] Allow custom new keyboard.
- [x] Can switch between keyboards.
- [ ] Allow change photo album.


![alt text](https://github.com/son11592/STKeyboard/blob/master/STKeyboard.gif)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
You must import `NSPhotoLibraryUsageDescription` in `Info.plist` in order to access Photo Library.

## Installation

STKeyboard is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "STKeyboard"
```

- Active keyboard
```
let textField = UITextField()

textField.switchToSTKeyboard(withType: .default)
textField.switchToSTKeyboard(withType: .number)
textField.switchToSTKeyboard(withType: .photo)
```

- Create a new keyboard by inheriting from `STKeyboard`
```
class NewCustomKeyboard: STKeyboard {

static let customKeyboard = NewCustomKeyboard()
}
```

## Author

Son Thai, hoangson11592@gmail.com

## License

STKeyboard is available under the MIT license. See the LICENSE file for more info.

Copyright (c) 2017 Son Thai (hoangson11592@gmail.com).

See the LICENSE file for more info.

