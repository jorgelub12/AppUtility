//
//  ViewController.swift
//  AppUtilityExample
//
//  Created by Sunil Sharma on 05/09/16.
//  Copyright © 2016 Sunil Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        auColorExamples()
        auLabelExamples()
        auAlertMessageExamples()
        auTextFieldExample()
        addInternetCheckButton()
        auStringExamples()
        auDateExamples()
        auImageViewExamples()
    }
    
    func auImageViewExamples() {
        let imageview = AUImageView(frame: CGRect(x: 20, y: 350, width: self.view.frame.size.width - 40, height: 200))
        self.view.addSubview(imageview)
        imageview.isUserInteractionEnabled = true
        imageview.enableImageZoom = true
        
        //http://www.hdwallpapers.in/download/city_of_arts_and_sciences_valencia_spain-1280x800.jpg
        //http://swmini.hu/wp-content/uploads/2016/11/2WYfLt.jpg
        
        imageview.imageWithURL("http://www.hd-wallpapersdownload.com/download/cute-tiger-pictures-wallpaper-1024x768/", withLoadingIndictor: true) { (status) in
            if !status {
                imageview.image = UIImage(named: "image.jpg")
            }
        }
    }
    
    func auDateExamples() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: "11/10/2020")
        let currentDate = Date()
        let noOfYear = currentDate.yearsFrom(Date.init(timeIntervalSince1970: 3000000000))
        let noOfMonths = currentDate.monthsFrom(date!)
        let noOfWeeks = currentDate.weeksFrom(date!)
        let noOfDays = currentDate.daysFrom(date!)
        let noOfHours = currentDate.hoursFrom(date!)
        let noOfMin = currentDate.minutesFrom(date!)
        let noOfSec = currentDate.secondsFrom(date!)

        let dateOffsets = Date().offsetFrom(date!)

        print("Number of years - \(noOfYear) \nNumber of months - \(noOfMonths) \nNumber of weeks - \(noOfWeeks) \nNumber of days - \(noOfDays) \nNumber of Hours \(noOfHours) \nNumber of Minutes \(noOfMin) \nNumber of Seconds \(noOfSec) \nDate Offsets - \(dateOffsets)")

    }

    func auStringExamples() {

        //Use of email Validation extension
        let emailString = "some@example.com"
        if emailString.isValidEmail() {
            print("Acceptable Email id")
        } else {
            print("Non acceptable Email id")
        }

        if emailString.isValidEmail("[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}") {
            print("Acceptable Email id")
        } else {
            print("Non acceptable Email id")
        }

        if emailString.validateWithRegexString("^[a-zA-Z0-9]+$") {
            print("Acceptable String")
        } else {
            print("Non acceptable string")
        }

        //Getting height of string via extension.
        let someString = "This string will  be used to calculate height of string through extension"
        print("string height \(someString.heightWithConstrainedWidth(320, font: UIFont.systemFont(ofSize: 15)))")
        print("string width \(someString.widthWithConstrainedHeight(45, font: UIFont.systemFont(ofSize: 15)))")
    }

    func auColorExamples() {
        //Use Color RGB Value
        self.view.backgroundColor = UIColor.init(redValue: 199, greenValue: 165, blueValue: 247)
        //self.view.backgroundColor = UIColor.init(hex:0xff0000, alpha:0.8)
        //self.view.backgroundColor = UIColor.init(hexCode: "#ff0000")
    }

    func auLabelExamples() {
        //Label with edge insets
        let auLabel = AULabel.init(frame:CGRect(x: 20, y: 40, width: 50, height: 30))
        //EdgeInsets to Label
        auLabel.edgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        auLabel.center.x = self.view.center.x
        auLabel.text = "hello"
        auLabel.numberOfLines = 0
        //Color from hex string
        auLabel.backgroundColor = UIColor.init(hexCode: "0xfff")
        self.view.addSubview(auLabel)
    }

    func auAlertMessageExamples() {
        let showAlertButton = UIButton.init(type: .custom)
        showAlertButton.frame = CGRect(x: 0, y: 100, width: 150, height: 50)
        showAlertButton.center.x = self.view.center.x
        showAlertButton.setTitle("Show Alert", for: UIControlState())
        showAlertButton.addTarget(self, action: #selector(showAlertButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(showAlertButton)
    }

    @objc func showAlertButtonPressed(_ sender: UIButton) {
        
        let alertView = AUAlertView(title: "Alert title", message: "Message")
        
        //Customisation
        alertView.alertViewAnimationType = .snapBehaviour
        alertView.backgroundType = .blurEffectLight
        alertView.isPanGestureEnabled = true
        alertView.dismissOnBackgroundTouch = true
        alertView.shouldDismissAlertViewByFlick = true
        
        let cancelButton = AUAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Clicked on cancel button")
        }
        
        let okButton = AUAlertAction(title: "Ok", style: .default) { (action) in
            print("Clicked on OK button")
        }
        //let other = AUAlertAction(title: "Other", style: .destructive)
        //alertView.addAction(other)
        alertView.addAction(cancelButton)
        alertView.addAction(okButton)
        alertView.show()
        
        //Show alertview with just cancel button
        //AUAlertView.showAlertView("Alert title", message: "Message", cancelButtonTitle: "OK")

    }
    
    func auAlertMessageClickedOn(button: UIButton, index: Int, title: String) {
        print("\(index) \(title)")
    }
    
    func auTextFieldExample() {
        let auTextField = AUTextFiled.init(frame:CGRect(x: 0, y: 220, width: 170, height: 40))
        //EdgeInsets to textfiled
        auTextField.edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        auTextField.center.x = self.view.center.x
        //Color from hex value
        auTextField.backgroundColor = UIColor.init(hex: 0xffffff)
        self.view.addSubview(auTextField)

        auTextField.text = "Teexxt with padding"
    }

    func addInternetCheckButton() {
        let netCheckButton = UIButton.init(type: .custom)
        netCheckButton.frame = CGRect(x: 0, y: 300, width: 200, height: 40)
        netCheckButton.center.x = self.view.center.x
        netCheckButton.setTitle("Check Net Connection", for: UIControlState())
        netCheckButton.addTarget(self, action: #selector(netCheckButtonPressed(_:)), for: .touchUpInside)
        self.view.addSubview(netCheckButton)
    }

    @objc func netCheckButtonPressed(_ sender: UIButton) {
        //Checking internet connection
        if AUReachability.sharedInstance.isNetworkReachable() {
            AUAlertView.showAlertView(nil, message: "Connected", cancelButtonTitle: "Cancel")
        }
        else {
            AUAlertView.showAlertView(nil, message: "Not Connected", cancelButtonTitle: "Cancel")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
