//
//  ViewController.swift
//  NAlertView
//
//  Created by Marc on 02/06/16.
//  Copyright © 2016 marc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showFirstAlert(sender: AnyObject) {
        applyAlertTheme1()
        
        NAlertView.showAlertInQueue(title: "First Alert",
                                    message: "It has some text in it",
                                    buttons: [AlertButton.init(title: "First Button", type: .Default)])
    }
    
    @IBAction func showSecondAlert(sender: AnyObject) {
        applyAlertTheme2()
        
        NAlertView.showAlertInQueue(title: "Second Alert",
                                    message: "It has some text in it",
                                    buttons: [AlertButton.init(title: "First Button", type: .Default),
                                        AlertButton.init(title: "Second Button", type: .Default),
                                        AlertButton.init(title: "Third Button", type: .Default),
                                        AlertButton.init(title: "Fourth Button", type: .Cancel)])
    }
    @IBAction func showThirdAlert(sender: AnyObject) {
        applyAlertTheme3()
        
        NAlertView.showAlertInQueue(title: "Third Alert",
                                    message: "It has some text in it",
                                    buttons: [AlertButton.init(title: "First Button", type: .Default),
                                        AlertButton.init(title: "Second Button", type: .Cancel)])
    }
    
    @IBAction func showFourAlert(sender: AnyObject) {
        applyAlertTheme4()
        
        NAlertView.showAlertInQueue(title: "Alert with completion block",
                                    message: "Some text here",
                                    buttons: [
                                        AlertButton.init(title: "First Button", type: .Default),
                                        AlertButton.init(title: "Second Button", type: .Default),
                                        AlertButton.init(title: "Third Button", type: .Cancel)]) { (btnPressed) in
                                            switch btnPressed {
                                            case 0:
                                                print("first button tapped")
                                            case 1:
                                                print("second button tapped")
                                            case 2:
                                                print("third button tapped")
                                            default:
                                                break
                                            }
        }
    }
    
    @IBAction func showFiveAlert(sender: AnyObject) {
        applyAlertTheme5()
        
        NAlertView.showAlertInQueue(title: nil,
                                    message: "Some text here",
                                    buttons: [
                                        AlertButton.init(title: "First Button", type: .Default),
                                        AlertButton.init(title: "Second Button", type: .Default),
                                        AlertButton.init(title: "Third Button", type: .Cancel)])
    }
    
    func applyAlertTheme1() {
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
    
    func applyAlertTheme2() {
        NAlertView.titleFont               = UIFont.init(name: "Verdana", size: 20)!
        NAlertView.titleColor              = UIColor.redColor()
        NAlertView.titleAlign              = NSTextAlignment.Left
        NAlertView.messageFont             = UIFont.init(name: "Verdana", size: 16)!
        NAlertView.messageColor            = UIColor.redColor()
        NAlertView.messageAlign            = NSTextAlignment.Left
        NAlertView.buttonCornerRadius      = 3
        NAlertView.buttonFont              = UIFont.init(name: "Verdana", size: 16)!
        NAlertView.buttonDefaultTitleColor = UIColor.redColor()
        NAlertView.buttonDefaultBGColor    = UIColor.blackColor()
        NAlertView.buttonAcceptTitleColor  = UIColor.redColor()
        NAlertView.buttonAcceptBGColor     = UIColor.blackColor()
        NAlertView.buttonCancelTitleColor  = UIColor.blackColor()
        NAlertView.buttonCancelBGColor     = UIColor.redColor()
    }
    
    func applyAlertTheme3() {
        NAlertView.titleFont               = UIFont.init(name: "Verdana", size: 20)!
        NAlertView.titleColor              = UIColor.blackColor()
        NAlertView.titleAlign              = NSTextAlignment.Right
        NAlertView.messageFont             = UIFont.init(name: "Verdana", size: 16)!
        NAlertView.messageColor            = UIColor.blackColor()
        NAlertView.messageAlign            = NSTextAlignment.Right
        NAlertView.buttonCornerRadius      = 3
        NAlertView.buttonFont              = UIFont.init(name: "Verdana", size: 16)!
        NAlertView.buttonDefaultTitleColor = UIColor.blueColor()
        NAlertView.buttonDefaultBGColor    = UIColor.yellowColor()
        NAlertView.buttonAcceptTitleColor  = UIColor.blueColor()
        NAlertView.buttonAcceptBGColor     = UIColor.yellowColor()
        NAlertView.buttonCancelTitleColor  = UIColor.blueColor()
        NAlertView.buttonCancelBGColor     = UIColor.yellowColor()
    }
    
    func applyAlertTheme4() {
        NAlertView.titleFont               = UIFont.init(name: "Verdana", size: 20)!
        NAlertView.titleColor              = UIColor.blueColor()
        NAlertView.titleAlign              = NSTextAlignment.Center
        NAlertView.messageFont             = UIFont.init(name: "Verdana", size: 16)!
        NAlertView.messageColor            = UIColor.blueColor()
        NAlertView.messageAlign            = NSTextAlignment.Center
        NAlertView.buttonCornerRadius      = 25
        NAlertView.buttonFont              = UIFont.init(name: "Verdana", size: 16)!
        NAlertView.buttonDefaultTitleColor = UIColor.whiteColor()
        NAlertView.buttonDefaultBGColor    = UIColor.blueColor()
        NAlertView.buttonAcceptTitleColor  = UIColor.redColor()
        NAlertView.buttonAcceptBGColor     = UIColor.blueColor()
        NAlertView.buttonCancelTitleColor  = UIColor.whiteColor()
        NAlertView.buttonCancelBGColor     = UIColor.blueColor()
    }
    
    func applyAlertTheme5() {
        NAlertView.titleFont               = UIFont.init(name: "Verdana", size: 20)!
        NAlertView.titleColor              = UIColor.blackColor()
        NAlertView.titleAlign              = NSTextAlignment.Center
        NAlertView.messageFont             = UIFont.init(name: "Verdana", size: 16)!
        NAlertView.messageColor            = UIColor.blackColor()
        NAlertView.messageAlign            = NSTextAlignment.Center
        NAlertView.buttonCornerRadius      = 25
        NAlertView.buttonFont              = UIFont.init(name: "Verdana", size: 16)!
        NAlertView.buttonDefaultTitleColor = UIColor.blackColor()
        NAlertView.buttonDefaultBGColor    = UIColor.greenColor()
        NAlertView.buttonAcceptTitleColor  = UIColor.blackColor()
        NAlertView.buttonAcceptBGColor     = UIColor.greenColor()
        NAlertView.buttonCancelTitleColor  = UIColor.blackColor()
        NAlertView.buttonCancelBGColor     = UIColor.greenColor()
    }
}

