# NAlertView
NAlertView is a highly customizable *Alert View Controller* written in *Swift*.

It is inspired by the [CPAlertViewController](https://github.com/cp3hnu/CPAlertViewController). It has been modified in order to make it more customizable.

## Examples

![](01.png)
![](02.png)
![](03.png)

## Installation

### Manually

The simplest way to install this library is to copy `NAlertView.swift` to your project.

### CocoaPods

Coming soon :)

### Usage

The usage of the Alert is very simple. First of all you need to configure how do you like your Alert to look like. In order to do this I strongly recomment to have a class (somewhere) named `Theam` with a method `applyAlertTheam()`. This method could look like this:

	``` swift
	public class Theme {
	    static func applyAlertTheme() {
	        GOGOAlert.titleFont               = Globals.font(Globals.GOGOFont.kelsonBold, size: 16)!
	        GOGOAlert.titleColor              = GOGOColor.blackCancelColor()
	        GOGOAlert.titleAlign              = NSTextAlignment.Left
	        GOGOAlert.messageFont             = Globals.font(Globals.GOGOFont.verdana, size: 14)!
	        GOGOAlert.messageColor            = GOGOColor.brownishGrey()
	        GOGOAlert.messageAlign            = NSTextAlignment.Left
	        GOGOAlert.buttonCornerRadius      = 3
	        GOGOAlert.buttonFont              = Globals.font(Globals.GOGOFont.verdana, size: 16)!
	        GOGOAlert.buttonDefaultTitleColor = GOGOColor.giaSunYellowColor()
	        GOGOAlert.buttonDefaultBGColor    = GOGOColor.tealBlue()
	        GOGOAlert.buttonAcceptTitleColor  = GOGOColor.tealBlue()
	        GOGOAlert.buttonAcceptBGColor     = GOGOColor.giaSunYellowColor()
	        GOGOAlert.buttonCancelTitleColor  = GOGOColor.giaDeepSeaBlueColor()
	        GOGOAlert.buttonCancelBGColor     = UIColor.clearColor()
	        GOGOAlert.buttonShadow            = 1
	    }
	}
	```

Then, this method should be called once in your AppDelegate, this way the theme that you have configured will be automatically applied to all the Alerts of your APP.

	``` swift
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Theme.applyAlertTheme()
        
        return true
    }
    ```

To show the alert you just have to call `NAlertView().showAlertInQueue` or `NAlertView().show` depending on weather or not you want to use the queue feature.

	``` swift
	NAlertView.showAlertInQueue(title: "First Alert",
                                    message: "It has some text in it",
                                    buttons: [AlertButton.init(title: "First Button", type: .Default)])
	```
	or
	``` swift
	NAlertView.show(title: "First Alert",
                        message: "It has some text in it",
                        buttons: [AlertButton.init(title: "First Button", type: .Default)])
	```

Actions after tapping a button of the alert can be done with a completion block:

	``` swift
	NAlertView.showAlertInQueue(title: "Alert with completion block",
                                 message: "Some text here",
                                 buttons: [
                                 	AlertButton.init(title: "First button", type: .Default),
                                    AlertButton.init(title: "Second Button", type: .Default),
                                    AlertButton.init(type: .Cancel)]) { (btnPressed) in
                                    switch btnPressed {
                                    case 0:
                                        print("first button tapped")
                                    case 1:
                                        print("second button tapped")
                                    default:
                                        break
                                    }
    }
    ``


### Customizable properties
	Here there is the list of all the properties than can be customized.

	``` swift
	/// The corner radious of the view
    public static var cornerRadius: Float = 4
    
    /// The font of the title
    public static var titleFont: UIFont = UIFont.systemFontOfSize(22)
    
    /// The text color of title
    public static var titleColor = UIColor.blackColor()
    
    /// The alignment of the title
    public static var titleAlign = NSTextAlignment.Center
    
    /// The color of the separation line between title and message
    public static var separationColor = UIColor(red: 238.0/255.0, green: 242.0/255.0, blue: 244.0/255.0, alpha: 1.0)
    
    /// The font of the message
    public static var messageFont: UIFont = UIFont.systemFontOfSize(16)
    
    /// The text color of message
    public static var messageColor = UIColor.blackColor()
    
    /// The alignment of the message
    public static var messageAlign = NSTextAlignment.Center
    
    /// The font size of title of button
    public static var buttonFont: UIFont = UIFont.systemFontOfSize(16)
    
    /// The text color of title of default button
    public static var buttonDefaultTitleColor = UIColor.whiteColor()
    
    /// The text color of title of accept button
    public static var buttonAcceptTitleColor = UIColor.whiteColor()
    
    /// The text color of title of cance; button
    public static var buttonCancelTitleColor = UIColor.whiteColor()
    
    /// The background color for the default button
    public static var buttonDefaultBGColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    
    /// The background color for the accept button
    public static var buttonAcceptBGColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    
    /// The background color for the cancel button
    public static var buttonCancelBGColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    
    /// The height of button
    public static var buttonHeight: Float = 50
    
    /// The corner radious of the button
    public static var buttonCornerRadius: Float = 0
    
    /// The shadow of the button
    public static var buttonShadow: Float = 0
	```


### Features

* Highly customizable
* Arbitrary number of buttons
* Alerts managed with a queue

### Requirements

* Swift 2.2
* Xcode 7.3

### Roadmap

* [Cocoapods](Documentation/CocoaPods.md)

### License

Released under the MIT license. See LICENSE for details.
