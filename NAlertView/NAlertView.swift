//
//  NAlertView.swift
//
//  Created by Marc on 31/05/16.
//  Copyright © 2016 Nikano. All rights reserved.
//


import UIKit

public enum ButtonsOrientation {
    case Horizontal
    case Vertical
}

/// Struct that stores all the information of an Alert
struct Alert: Equatable {
    var title: String
    let message: String
    let buttonsTitle: [AlertButton]
    let buttonsOrientation: ButtonsOrientation
    let completion: ((btnPressed:Int) -> Void)?
}

func ==(lhs: Alert, rhs: Alert) -> Bool {
    return lhs.title == rhs.title && lhs.message == rhs.message
}

public typealias UserAction = ((buttonIndex: Int) -> Void)

public class NAlertView: UIViewController, UIGestureRecognizerDelegate {
    
    // To manage the pending alerts
    static private var arrayAlerts: [Alert] = []
    static private var isAlertShown: Bool = false
    
    //MARK: - Custom Properties
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
    
    //MARK: - Const
    private let kBGTransparency: CGFloat = 0.43
    private let kVerticalGap: CGFloat = 15.0
    private let kWidthMargin: CGFloat = 20.0
    private let kHeightMargin: CGFloat = 15.0
    private let kContentWidth: CGFloat = 270.0
    private let kContentHeightMargin: CGFloat = 20.0
    private let kTitleLines: Int = 3
    private let kButtonBaseTag: Int = 100
    private let kButtonHoriSpace: CGFloat = 5.0
    private var titleLabelSpace: CGFloat = 0.0
    private let separatorSpace: CGFloat = 10.0
    private var messageTextViewSpace: CGFloat = 0.0
    private var buttonsOrientation: ButtonsOrientation = .Horizontal
    
    //MARK: - View
    private var strongSelf: NAlertView?
    private var contentView = UIView()
    private var titleLabel: UILabel = UILabel()
    private var separatorView = UIView()
    private var messageLabel = UILabel()
    private var buttons: [UIButton] = []
    private var userAction: UserAction? = nil
    
    //MARK: - Init
    public init() {
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.frame = UIScreen.mainScreen().bounds
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        self.view.backgroundColor = UIColor(white: 0.0, alpha: kBGTransparency)
        
        strongSelf = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    private func setupContentView() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        contentView.layer.cornerRadius = CGFloat(NAlertView.cornerRadius)
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        contentView.layer.borderColor = UIColor.init(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).CGColor
        self.view.addSubview(contentView)
        
        //Constraints
        let heightConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[contentView]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kContentHeightMargin], views: ["contentView": contentView])
        for constraint in heightConstraints {
            constraint.priority = UILayoutPriorityDefaultHigh
        }
        self.view.addConstraints(heightConstraints)

        self.view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Leading , relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1.0, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: view, attribute: .Trailing , relatedBy: .Equal, toItem: contentView, attribute: .Trailing, multiplier: 1.0, constant: 20))

        self.view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    private func addContentSubviewConstraints() {
        
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[label]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kWidthMargin], views: ["label": titleLabel]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[textView]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kWidthMargin], views: ["textView": messageLabel]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[separatorView]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kWidthMargin], views: ["separatorView": separatorView]))
        
        if buttons.count > 0 {
            let firstButton = buttons.first!
            let lastButton = buttons.last!
            
            if buttons.count == 2 && buttonsOrientation == .Horizontal {
                let firstButton = buttons.first!
                contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[firstButton]-space-[lastButton(==firstButton)]-margin-|", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: ["margin": kWidthMargin, "space": kButtonHoriSpace], views: ["firstButton": firstButton, "lastButton": lastButton]))
            } else {
                var previousButton: UIButton? = nil
                for button in buttons {
                    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[button]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kWidthMargin], views: ["button": button]))
                    
                    if button != firstButton {
                        if let previousBtn = previousButton {
                            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[previousButton]-space-[button]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["space": kButtonHoriSpace], views: ["previousButton": previousBtn, "button": button]))
                        }
                    }
                    
                    previousButton = button
                }
            }
            
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[label]-titleSpaceUp-[separatorView]-titleSpaceDown-[textView]-textViewSpace-[button]", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kHeightMargin, "titleSpaceUp": titleLabelSpace, "titleSpaceDown": separatorSpace, "textViewSpace": messageTextViewSpace], views: ["label": titleLabel, "separatorView": separatorView, "textView": messageLabel, "button": firstButton]))
            
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[button]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kWidthMargin], views: ["button": lastButton]))
        } else {
            contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[label]-titleSpaceUp-[separatorView]-titleSpaceDown-[textView]-margin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: ["margin": kHeightMargin, "titleSpaceUp": titleLabelSpace, "titleSpaceDown": separatorSpace], views: ["label": titleLabel, "separatorView": separatorView, "textView": messageLabel]))
        }
        
        titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
        messageLabel.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Vertical)
    }
    
    private func setupTitleLabel(title: String?) {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = kTitleLines
        titleLabel.textAlignment = NAlertView.titleAlign
        titleLabel.text = title
        titleLabel.font = NAlertView.titleFont
        titleLabel.textColor = NAlertView.titleColor
        titleLabel.backgroundColor = UIColor.clearColor()
        contentView.addSubview(titleLabel)
        
        if let aTitle = title where aTitle.isEmpty == false {
            titleLabelSpace = kVerticalGap
        }
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = NAlertView.separationColor
        contentView.addSubview(separatorView)
        
        // Separator height constraint
        separatorView.addConstraint(NSLayoutConstraint(item: separatorView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 1))
    }
    
    private func setupMessageTextView(message: String?) {
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textAlignment = NAlertView.messageAlign
        messageLabel.text = message ?? ""
        messageLabel.font = NAlertView.messageFont
        messageLabel.textColor = NAlertView.messageColor
        messageLabel.numberOfLines = 0
        messageLabel.backgroundColor = UIColor.clearColor()
        contentView.addSubview(messageLabel)
        
        if messageLabel.text?.isEmpty == false {
            messageTextViewSpace = kContentHeightMargin
        }
    }
    
    private func setupButtons(arrayButtons: [AlertButton]) {
        
        for button in arrayButtons {
            let btn = createButton(button)
            contentView.addSubview(btn)
            buttons.append(btn)
        }
    }
    
    private func createButton(alertButton: AlertButton) -> UIButton {
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = kButtonBaseTag + buttons.count
        button.layer.cornerRadius = CGFloat(NAlertView.buttonCornerRadius)
        button.layer.masksToBounds = true
        button.setTitle(alertButton.title, forState: .Normal)
        button.titleLabel?.font = NAlertView.buttonFont
        
        switch alertButton.type {
        case .Accept:
            button.setTitleColor(NAlertView.buttonAcceptTitleColor, forState: .Normal)
            button.setBackgroundImage(NAlertView.buttonAcceptBGColor.image(), forState: .Normal)
            button.setBackgroundImage((NAlertView.buttonAcceptBGColor).darkerColor().image(), forState: .Highlighted)
        case .Cancel:
            button.setTitleColor(NAlertView.buttonCancelTitleColor, forState: .Normal)
            button.setBackgroundImage(NAlertView.buttonCancelBGColor.image(), forState: .Normal)
            button.setBackgroundImage((NAlertView.buttonCancelBGColor).darkerColor().image(), forState: .Highlighted)
        case .Default:
            button.setTitleColor(NAlertView.buttonDefaultTitleColor, forState: .Normal)
            button.setBackgroundImage(NAlertView.buttonDefaultBGColor.image(), forState: .Normal)
            button.setBackgroundImage((NAlertView.buttonDefaultBGColor).darkerColor().image(), forState: .Highlighted)
        }
        
        button.backgroundColor = UIColor.clearColor()
        button.addTarget(self, action: #selector(NAlertView.pressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //Height constraints
        button.addConstraint(NSLayoutConstraint(item: button, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: CGFloat(NAlertView.buttonHeight)))
        
        return button
    }
    
    @objc private func pressed(sender: UIButton) {
        
        let index = sender.tag - kButtonBaseTag
        close(clickedAtIndex:index)
    }
    
    @objc private func backgroundTapped(sender: AnyObject) {
        close(clickedAtIndex: nil)
    }
    
    private func close(clickedAtIndex index: Int?) {
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.view.alpha = 0.0
        }) { (Bool) -> Void in
            
            self.contentView.removeFromSuperview()
            self.contentView = UIView()
            
            self.view.removeFromSuperview()
            
            //Releasing strong refrence of itself.
            self.strongSelf = nil
            
            // Remove alert from quued and show next
            NAlertView.arrayAlerts.removeFirst()
            NAlertView.showNext()
            
            // Button completion
            if let action = self.userAction, let ind = index {
                action(buttonIndex: ind)
            }
        }
    }
    
    private func animateAlert() {
        
        view.alpha = 0
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.alpha = 1.0
        })
        
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = [NSValue(CATransform3D: CATransform3DMakeScale(0.95, 0.95, 0.0)), NSValue(CATransform3D: CATransform3DMakeScale(1.03, 1.03, 0.0)), NSValue(CATransform3D: CATransform3DMakeScale(0.98, 0.98, 0.0)), NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 0.0))]
        animation.keyTimes = [0, 2.0/4.0, 3.0/4.0, 1]
        animation.additive = true
        animation.duration = 0.4
        self.contentView.layer.addAnimation(animation, forKey: "animation")
    }
    
    //MARK: - Show
    
    /**
     Shows a custom NAlertView
     
     - parameter title:             The title of the alert.
     - parameter message:           The message of the alert.
     - parameter buttons:           An array of AlertButton that contains the title and the style of each button
     - parameter target:            The UIViewController which will present the SGAlert
     - parameter completion:        The completion function to be executed after having tapped a button.
     
     If an alerts need to be shown while another alert is displayed, the second one will appear after having closed the first one.
     */
    static func showAlertInQueue(title title: String?, message: String, buttons: [AlertButton], buttonsOrientation: ButtonsOrientation = .Horizontal, completion: ((btnPressed:Int) -> Void)? = nil) {
        var alert = Alert(title: "", message: message, buttonsTitle: buttons, buttonsOrientation: buttonsOrientation, completion: completion)
        
        if let titleAux = title {
            alert.title = titleAux
        }
        
        if (!arrayAlerts.contains(alert)) {
            arrayAlerts.append(alert)
            if !isAlertShown {
                showNext()
            }
        }
    }
        
    private static func showNext() {
        
        isAlertShown = true
        
        // check if there are alerts pending
        if (arrayAlerts.count > 0) {
            let alert = arrayAlerts[0]
            
            NAlertView().show(title: alert.title, message: alert.message, buttons: alert.buttonsTitle, buttonsOrientation: alert.buttonsOrientation, action: alert.completion)
        } else {
            isAlertShown = false
        }
    }

    public func show(title title: String?, message: String?, buttons: [AlertButton], buttonsOrientation: ButtonsOrientation = .Horizontal, action: UserAction? = nil) {
        
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        window.addSubview(view)
        window.bringSubviewToFront(view)
        view.frame = window.bounds
        
        // Add tap recognizer to the background
        let viewBackground = UIView()
        viewBackground.backgroundColor = UIColor.clearColor()
        viewBackground.frame = view.frame
        view.addSubview(viewBackground)
        let tap = UITapGestureRecognizer(target: self, action: #selector(NAlertView.backgroundTapped(_:)))
        tap.delegate = self
        viewBackground.addGestureRecognizer(tap)
        
        // Setup alert
        self.buttonsOrientation = buttonsOrientation
        self.userAction = action
        setupContentView()
        setupTitleLabel(title)
        setupMessageTextView(message)
        setupButtons(buttons)
        addContentSubviewConstraints()
        
        // Show alert
        animateAlert()
    }
}

public struct AlertButton {
    enum ButtonType {
        case Default
        case Accept
        case Cancel
    }
    
    var title: String
    var type: ButtonType
    
    init(title: String, type: ButtonType) {
        self.title = title
        self.type = type        
    }
}

extension UIColor {
    
    func darkerColor() -> UIColor {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.05, 0.0), green: max(g - 0.05, 0.0), blue: max(b - 0.05, 0.0), alpha: a)
        }
        
        return UIColor()
    }
    
    func image() -> UIImage {
        
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, self.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}




