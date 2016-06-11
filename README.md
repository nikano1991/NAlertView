# NAlertView
NAlertView is a highly customizable **Alert View Controller** written in **Swift**.

It is inspired by the [CPAlertViewController](https://github.com/cp3hnu/CPAlertViewController). It has been modified in order to make it more customizable.

## Examples

![](Screenshots/01.png =100x) ![](Screenshots/02.png =100x) ![](Screenshots/03.png =100x) ![](Screenshots/04.png =100x) ![](Screenshots/05.png =100x)

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
        NAlertView.cornerRadius             = 4
        NAlertView.titleFont                = UIFont.systemFontOfSize(22)
        NAlertView.titleColor               = UIColor.blackColor()
        NAlertView.titleAlign               = NSTextAlignment.Center
        NAlertView.separationColor          = UIColor(red: 238.0/255.0, green: 242.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        NAlertView.messageFont              = UIFont.systemFontOfSize(16)
        NAlertView.messageColor             = UIColor.blackColor()
        NAlertView.messageAlign             = NSTextAlignment.Center
        NAlertView.buttonFont               = UIFont.systemFontOfSize(16)
        NAlertView.buttonDefaultTitleColor  = UIColor.whiteColor()
        NAlertView.buttonAcceptTitleColor   = UIColor.whiteColor()
        NAlertView.buttonCancelTitleColor   = UIColor.whiteColor()
        NAlertView.buttonDefaultBGColor     = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        NAlertView.buttonAcceptBGColor      = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        NAlertView.buttonCancelBGColor      = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        NAlertView.buttonHeight             = 50
        NAlertView.buttonCornerRadius       = 0
        NAlertView.buttonShadow             = 0
    }
}
```
Then, this method should be called once in your AppDelegate, this way the theme that you have configured will be automatically applied to all the Alerts of your APP.

``` swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    Theme.applyAlertTheme()
    
    return true
}
````

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
```

The alert view will appear with a (very) fancy `pop` animation, if you seek to implement you own animation you can do so by overriding the `animateAlert()` method.

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

* Make library available on [Cocoapods](Documentation/CocoaPods.md)

### License

Released under the MIT license. See LICENSE for details.
