# STKeyboard
Custom keyboards for iOS applications.

# Features
	+ Switch between 3 kinds of keyboard
	+ Support for both UITextField and UITextView
	+ Support number keyboard.
	+ Support photo keyboard.
	
# Installation

 - CocoaPods

 - Manual

Drag and drop Classes folder into your project.

# Usage

  - Active keyboard
```
let textField = UITextField()

textField.switchToSTKeyboard(withType: STKeyboardType.default)
textField.switchToSTKeyboard(withType: STKeyboardType.number)
textField.switchToSTKeyboard(withType: STKeyboardType.photo)
```

  - Create a new keyboard by inheriting from `STKeyboard`
```
class NewCustomKeyboard: STKeyboard {

  static let customKeyboard = NewCustomKeyboard()

  override func commonInit() {
    super.commonInit()
    
    // Write your code here!
  }
}
```
  - Then we can switch to this new keyboard by
```
let textField = UITextField()

textField.switchToSTKeyboard(keyboard: NewCustomKeyboard.customKeyboard)
```


# Contact

hoangson11592@gmail.com

If you use/enjoy STKeyboard, let me know!

# License

See the LICENSE file for more info.
