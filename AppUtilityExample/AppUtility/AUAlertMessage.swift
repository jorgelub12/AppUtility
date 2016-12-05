//
//  AUAlertMessage.swift
//  AppUtility
//
//  Created by Sunil Sharma on 22/08/16.
//  Copyright © 2016 Sunil Sharma. All rights reserved.
//

import Foundation
import UIKit

<<<<<<< HEAD
class AUAlertMessage: UIView {
    
    let alertView = UIView()
    let backgroundView = UIView()
    private let innerView:UIView = UIView()
    let buttonHeight:CGFloat = 40.0
    
    private var animator:UIDynamicAnimator? = nil
    private var attachmentBehaviour:UIAttachmentBehavior? = nil
    private var alertViewDragStartPoint:CGPoint? = nil
    private var alertViewDragOffsetFromActualTranslation:UIOffset? = nil
    private var alertViewDragOffsetFromCenter:UIOffset? = nil
    private var alertViewIsFlickingAwayForDismissal = false
    private var isDraggingAlertView = false
    
    let minimumFlickDismissalVelocity:Float = 1400.0
    open var animationDuration:Double = 0.4
    open var contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
    
    var titleLabel:UILabel = UILabel()
    var messageLabel:UILabel = UILabel()
    var cancelButton:UIButton = UIButton(type: .custom)
    var otherButtonTitlesArray:[String?]? = nil
    
    
    init() {
        super.init(frame: CGRect.zero)
        initialSetup()
    }
    
    public convenience init(title: String?, message: String?, cancelButtonTitle: String?) {
        self.init()
        addInnerViews(title: title, message: message, cancelButtonTitle: cancelButtonTitle,firstButtonTitle: nil, otherButtonTitles: nil)
    }
    
    public convenience init(title:String?, message:String?, cancelButtonTitle:String?, otherButtonTitles firstButtonTitle: String, _ moreButtonTitles:String...) {
        self.init()
        addInnerViews(title: title, message: message, cancelButtonTitle: cancelButtonTitle,firstButtonTitle: firstButtonTitle, otherButtonTitles: moreButtonTitles)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //super.init(coder: aDecoder)
    }
    
    private func initialSetup(){
        self.backgroundColor = UIColor.clear
        self.animator = UIDynamicAnimator.init(referenceView: self)
        self.isUserInteractionEnabled = true
        
        //InnerView
        innerView.backgroundColor = UIColor.clear
        innerView.clipsToBounds = true
        innerView.layer.cornerRadius = 2
        
        setupAlertView()
    }
    
=======
open class AUAlertMessage: UIView {
    
>>>>>>> 26888b27c39096e9012ebc8cc2d2129d738dc6f1
    open func showAlertView(_ title:String?, message:String?, cancelButtonTitle:String?) {
        let alert = UIAlertView.init(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButtonTitle)
        alert.show()
    }
    
<<<<<<< HEAD
    private func setupAlertView() {
        
        let keyWindow = UIApplication.shared.keyWindow
        self.frame = keyWindow?.bounds ?? CGRect.zero
        
        backgroundView.frame = keyWindow?.bounds ?? CGRect.zero
        backgroundView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.4)
        backgroundView.alpha = 1.0
        self.addSubview(backgroundView)
        
        let alertViewHorizontalPadding:CGFloat = 40
        alertView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width - alertViewHorizontalPadding, height: 100)
        alertView.backgroundColor = UIColor.white
        alertView.layer.cornerRadius = 8.0
        alertView.layer.masksToBounds = true
        alertView.tintAdjustmentMode = .normal
        alertView.isUserInteractionEnabled  = true
        
        self.innerView.frame = CGRect(x: contentEdgeInsets.left, y: contentEdgeInsets.top, width: alertView.frame.size.width - (contentEdgeInsets.left + contentEdgeInsets.right), height: alertView.frame.size.height - (contentEdgeInsets.top + contentEdgeInsets.bottom))
        alertView.addSubview(innerView)
        self.addSubview(alertView)
    }
    
    func addInnerViews(title:String?, message:String?, cancelButtonTitle:String?,firstButtonTitle: String?, otherButtonTitles: [String]?) {
        if let titleString = title {
        configTitleLabel(title: titleString)
        }
        if let messageString = message {
        configMessageLabel(message: messageString)
        }
        if (title != nil || message != nil) {
        addSublayerLine()
        }
        
        if cancelButtonTitle != nil {
            
        }
        
        if let firstTitleString = firstButtonTitle {
            addOtherButtons(buttonTitles: [firstTitleString])
        }
        addOtherButtons(buttonTitles: otherButtonTitles!)
        if let cancelTitleString = cancelButtonTitle {
            configCancelButton(title: cancelTitleString)
        }
        resizeAlertViewHeight()
    }
    
    func addOtherButtons(buttonTitles:[String]) {
        let lastViewFrame = getLastViewFrame(view: self.innerView)
        let messageLabelEndY = lastViewFrame.origin.y + lastViewFrame.size.height  + 8
        for (index,title) in buttonTitles.enumerated() {
            let button = UIButton.init(type: .custom)
            let buttonYOffset = messageLabelEndY + (buttonHeight * CGFloat(index)) +  CGFloat(index * 1)
            button.frame = CGRect(x: 0.0, y: buttonYOffset, width: self.innerView.frame.size.width, height: buttonHeight)
            button.layer.cornerRadius = 2
            button.clipsToBounds = true
            button.titleLabel?.minimumScaleFactor = 0.8
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.setTitle(title, for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
            button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
            innerView.addSubview(button)
        }
    }
    
    func getLastViewFrame(view:UIView) -> CGRect{
        
        var frame:CGRect = CGRect.zero
        let innerSubViews = self.innerView.subviews
        if innerSubViews.count > 0 {
            let view = innerSubViews[innerSubViews.count - 1]
            frame = view.frame
        }
        return frame
    }
    
    func configCancelButton(title: String) {
        let lastViewFrame = getLastViewFrame(view: self.innerView)
        cancelButton.frame = CGRect(x: 0.0, y: lastViewFrame.origin.y + lastViewFrame.size.height + 6, width:lastViewFrame.size.width, height: buttonHeight)
        cancelButton.layer.cornerRadius = 2
        cancelButton.clipsToBounds = true
        cancelButton.titleLabel?.minimumScaleFactor = 0.8
        cancelButton.titleLabel?.adjustsFontSizeToFitWidth = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.blue, for: .normal)
        cancelButton.backgroundColor = UIColor.red
        cancelButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        innerView.addSubview(cancelButton)
    }
    
    func resizeAlertViewHeight() {
        
        let lastViewFrame = getLastViewFrame(view: self.innerView)
        
        alertView.frame.size.height = lastViewFrame.origin.y + lastViewFrame.size.height + contentEdgeInsets.top + contentEdgeInsets.bottom
        innerView.frame.size.height = alertView.frame.size.height - (contentEdgeInsets.top + contentEdgeInsets.bottom)
    }
    
    func configMessageLabel(message: String) {
        let lastViewFrame = getLastViewFrame(view: self.innerView)
        self.messageLabel.frame = CGRect(x: 0.0, y: lastViewFrame.origin.y + lastViewFrame.size.height + 10 , width: self.innerView.frame.size.width, height: 0)
        self.messageLabel.text = "Some message"
        self.messageLabel.backgroundColor = UIColor.clear
        self.messageLabel.textColor = UIColor.black
        self.messageLabel.font = UIFont.systemFont(ofSize: 16)
        self.messageLabel.textAlignment = .center
        self.messageLabel.lineBreakMode = .byWordWrapping
        self.messageLabel.numberOfLines = 0
        self.messageLabel.frame.size.height = self.messageLabel.text?.heightWithConstrainedWidth(self.innerView.frame.size.width, font: UIFont.systemFont(ofSize: 16)) ?? 0.0
        self.innerView.addSubview(self.messageLabel)
        
    }
    
    func configTitleLabel(title: String) {
        self.titleLabel.frame = CGRect(x: 0.0, y: 0.0, width: self.innerView.frame.size.width, height: 0)
        titleLabel.text = "SomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomethingSomething"
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        
        titleLabel.frame.size.height = titleLabel.text?.heightWithConstrainedWidth(self.innerView.frame.size.width, font: UIFont.boldSystemFont(ofSize: 17)) ?? 0.0
        self.innerView.addSubview(self.titleLabel)
    }
    
    //Gestures and Animation
    func addGesture() {
        print("\(#function)")
        let tapGestureRecogniser = UITapGestureRecognizer.init(target: self, action: #selector(dismissOnBackgroundTouch(_:)))
        tapGestureRecogniser.numberOfTapsRequired = 1
        self.backgroundView.isUserInteractionEnabled = true
        self.backgroundView.isMultipleTouchEnabled = false
        self.backgroundView.addGestureRecognizer(tapGestureRecogniser)
        
        //Pan Gesture
        let panRecogniser = UIPanGestureRecognizer.init(target: self, action: #selector(dismissingPanGestureRecogniserPanned(_:)))
        panRecogniser.maximumNumberOfTouches = 1
        self.alertView.addGestureRecognizer(panRecogniser)
    }
    
    func dismissingPanGestureRecogniserPanned(_ panner:UIPanGestureRecognizer) {
        
        let translation = panner.translation(in: self)
        let locationInView = panner.location(in: self)
        let velocity = panner.velocity(in: self)
        let vectorDistance = sqrtf(powf(Float(velocity.x), 2) + powf(Float(velocity.y), 2))
        
        isDraggingAlertView = self.alertView.frame.contains(locationInView)
        
        if panner.state == .began {
            if isDraggingAlertView == true {
                self.startAlerViewDragging(location: locationInView, translationOffset: UIOffset.zero)
            }
        }
        else if panner.state == .changed {
            if isDraggingAlertView == true {
                var newAnchor = alertViewDragStartPoint
                newAnchor?.x += translation.x + (alertViewDragOffsetFromActualTranslation?.horizontal ?? 0)
                newAnchor?.y += translation.y + (alertViewDragOffsetFromActualTranslation?.vertical ?? 0)
                self.attachmentBehaviour?.anchorPoint = newAnchor ?? CGPoint.zero
            }
            else {
                isDraggingAlertView = self.alertView.frame.contains(locationInView)
                if isDraggingAlertView == true {
                    let translationOffset = UIOffset.init(horizontal: -1 * translation.x, vertical: -1 * translation.y)
                    self.startAlerViewDragging(location: locationInView, translationOffset: translationOffset)
                }
            }
        }
        else {
            if (vectorDistance > minimumFlickDismissalVelocity){
                if isDraggingAlertView {
                    self.dismissAlertViewWithFlick(velocity)
                }
                else {
                    dismiss()
                }
            }
            else {
                self.cancelCurrentAlertviewDrag(true)
            }
        }
    }
    
    func cancelCurrentAlertviewDrag(_ animated:Bool) {
        print(#function)
        self.animator?.removeAllBehaviors()
        self.attachmentBehaviour = nil
        isDraggingAlertView = false
        if animated == false {
            self.alertView.transform = .identity
            self.alertView.center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2)
        }
        else{
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
                if self.isDraggingAlertView == false {
                    self.alertView.transform = .identity
                    self.alertView.center = CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
                }
            }, completion: nil)
        }
    }
    
    func dismissAlertViewWithFlick(_ velocity:CGPoint) {
        print(#function)
        self.alertViewIsFlickingAwayForDismissal = true
        let push = UIPushBehavior.init(items: [self.alertView], mode: .instantaneous)
        push.pushDirection = CGVector.init(dx: velocity.x * 0.1, dy: velocity.y * 0.1)
        push.setTargetOffsetFromCenter(self.alertViewDragOffsetFromCenter!, for: self.alertView)
        push.action = {
            if self.alertViewIsOffScreen() {
                self.animator?.removeAllBehaviors()
                self.attachmentBehaviour = nil
                self.dismiss()
            }
        }
        self.animator?.removeBehavior(self.attachmentBehaviour!)
        self.animator?.addBehavior(push)
    }
    
    func alertViewIsOffScreen() -> Bool{
        return self.animator?.items(in: self.frame).count == 0
    }
    
    func startAlerViewDragging(location:CGPoint, translationOffset:UIOffset) {
        print(#function)
        self.animator?.removeAllBehaviors()
        self.alertViewDragStartPoint = location
        self.alertViewDragOffsetFromActualTranslation = translationOffset
        let anchor = self.alertViewDragStartPoint
        let alertViewCenter = self.alertView.center
        
        let offset = UIOffsetMake(location.x - alertViewCenter.x, location.y - alertViewCenter.y)
        self.alertViewDragOffsetFromCenter = offset
        
        self.attachmentBehaviour = UIAttachmentBehavior.init(item: self.alertView, offsetFromCenter: offset, attachedToAnchor: anchor ?? CGPoint.zero)
        self.animator?.addBehavior(self.attachmentBehaviour!)
        
        let modifier = UIDynamicItemBehavior.init(items: [self.alertView])
        modifier.angularResistance = appropriateAngularResistanceForView(self.alertView)
        modifier.density = appropriateDensityForView(self.alertView)
        self.animator?.addBehavior(modifier)
    }
    
    func appropriateAngularResistanceForView(_ view:UIView) -> CGFloat{
        let height = view.bounds.size.height
        let width = view.bounds.size.width
        
        let actualArea = height * width
        let referenceArea = self.bounds.size.width * self.bounds.size.height
        let factor = referenceArea / actualArea
        let defaultDensity:CGFloat = 4.0
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let resistance = defaultDensity * (referenceArea / (screenWidth * screenHeight))
        return resistance * factor
    }
    
    func appropriateDensityForView(_ view:UIView) -> CGFloat {
        let height = view.bounds.size.height
        let width = view.bounds.size.width
        let actualArea = height * width
        let referenceArea = self.bounds.size.width * self.bounds.size.height
        let factor = referenceArea / actualArea
        let defaultDensity:CGFloat = 0.5
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let appropriateDensity = defaultDensity * (referenceArea / (screenWidth * screenHeight))
        return appropriateDensity * factor
    }

    func addSublayerLine() {
        
        let lineLayer = CALayer()
        lineLayer.backgroundColor = UIColor.init(white: 0.0, alpha: 0.29).cgColor
        lineLayer.frame = CGRect(x: 0.0, y: self.messageLabel.frame.origin.y + self.messageLabel.frame.size.height + 4, width: self.innerView.frame.size.width, height: 0.5)
        self.innerView.layer.addSublayer(lineLayer)
    }
    
    func show() {
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self)
        
        let snapBehaviour = UISnapBehavior.init(item: self.alertView, snapTo: (keyWindow?.center)!)
        snapBehaviour.damping = 0.51
        self.animator?.addBehavior(snapBehaviour)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.backgroundView.alpha = 1.0
        }, completion: { (finished) in
                self.addGesture()
        })
    }
    
    func dismissOnBackgroundTouch(_ gestureRecognizer:UITapGestureRecognizer){
        
        guard let senderView = gestureRecognizer.view
            else {
                return
        }
        
        if gestureRecognizer.state == .ended {
            let location = gestureRecognizer.location(in: senderView.superview)
            let closeSuperView = self.isTappedOutsideRegion(self.alertView, withLocation: location)
            if closeSuperView == true {
                self.dismiss()
            }
        }
    }
    
    func isTappedOutsideRegion(_ view:UIView, withLocation location:CGPoint) -> Bool {
        let endX = view.frame.origin.x + view.frame.size.width
        let endY = view.frame.origin.y + view.frame.size.height
        
        var isValid:Bool = false
        if (location.x < view.frame.origin.x || location.y < view.frame.origin.y) || (location.x > endX || location.y > endY) {
            isValid = true
        }
        return isValid
    }
    
    func dismiss() {
        let keyWindow = UIApplication.shared.keyWindow
        self.animator?.removeAllBehaviors()
        
        /*let gravityBehaviour = UIGravityBehavior.init(items: [self.alertView])
        gravityBehaviour.gravityDirection = CGVector(dx: 0, dy: 10)
        self.animator?.addBehavior(gravityBehaviour)

        let itemBehaviour = UIDynamicItemBehavior.init(items: [self.alertView])
        itemBehaviour.addAngularVelocity(CGFloat(-M_PI_2), for: self.alertView)
        self.animator?.addBehavior(itemBehaviour)*/
        
        UIView.perform(.delete, on: [self.alertView], options: .curveEaseInOut, animations: {[weak self] in
            self?.backgroundView.alpha = 0.0
            keyWindow?.tintAdjustmentMode = .automatic
            keyWindow?.tintColorDidChange()
            },
            completion: {[weak self] (finished) in
                self?.removeFromSuperview()
        })

        
        /*UIView.animate(withDuration: animationDuration, animations: {[weak self] in
            self?.backgroundView.alpha = 0.0
            keyWindow?.tintAdjustmentMode = .automatic
            keyWindow?.tintColorDidChange()
            }, completion: {[weak self] (finished) in
                self?.removeFromSuperview()
        })*/
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

class AlertView: UIAlertView {
    
    var animator:UIDynamicAnimator? = nil
    
    override func show() {
        super.show()
        self.frame.origin = CGPoint.zero
        self.animator = UIDynamicAnimator.init(referenceView: self)
        let keyWindow = UIApplication.shared.keyWindow
        //keyWindow?.addSubview(self)
        
        //            UIView.animate(withDuration: 0.4, animations: {
        //                //self.backgroundView.alpha = 1.0
        //            }, completion: { (finished) in
        //                self.addGesture()
        //            })
        
        let snapBehaviour = UISnapBehavior.init(item: self, snapTo: (keyWindow?.center)!)
        snapBehaviour.damping = 0.65
        self.animator?.addBehavior(snapBehaviour)
        
    }
    
    func addGesture() {
        print("\(#function)")
        //let tapGestureRecogniser = UITapGestureRecognizer.init(target: self, action: #selector(dismissOnBackgroundTouch(_:)))
        //tapGestureRecogniser.numberOfTapsRequired = 1
        
    }
=======
>>>>>>> 26888b27c39096e9012ebc8cc2d2129d738dc6f1
}
