//
//  TextFieldsEffects.swift
//  TextFieldEffects
//
//  Created by Raúl Riera on 24/01/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import Photos

extension String {
    /**
    true iff self contains characters.
    */
    public var isNotEmpty: Bool {
        return !isEmpty
    }
}
extension UITextField
{
    public func setDoneOnKeyboard()
    {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.inputAccessoryView = keyboardToolbar
        //        self.txt_mail.inputAccessoryView = keyboardToolbar
    }
    
    func dismissKeyboard()
    {
        self.endEditing(true)
    }
}
extension UIColor {
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.characters.dropFirst() : hexString.characters)  // Swift 4 just use `var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])`
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
}
extension UIButton
{
    public func setButtonTitle()
    {
        titleLabel?.minimumScaleFactor = 0.5
        //titleLabel?.numberOfLines = 0
        titleLabel?.adjustsFontSizeToFitWidth = true
    //        self.txt_mail.inputAccessoryView = keyboardToolbar
    }
    
    func dismissKeyboard()
    {
        self.endEditing(true)
    }
}

extension UIViewController
{
   
    func displayAlertMessage(messageToDisplay: String)
    {
        let baner =  Banner(title: "Alert", subtitle: messageToDisplay , image: nil, backgroundColor: .orange)
        baner.position = .top
        baner.show(duration: 0.9)

    }
    func displayServerAlertMessageee(messageToDisplay: String,imageee:UIImage)
    {
        let baner =  Banner(title: "Alert", subtitle: messageToDisplay , image:imageee, backgroundColor:.red)
        baner.position = .bottom
        baner.show(duration: 0.9)
    }
}

extension UIViewController
{
    func ShowAlertLogin()
    {
        let alert = UIAlertController(title: "", message:"Authentication Failed! Invalid Username & Password.", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:
        {
            (alert:UIAlertAction!) -> Void in
        })
        alert.addAction(cancelAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
        STOP_INDICATOR()
    }
    
    func ShowAlertInterConnection()
    {
        let alert = UIAlertController(title: "", message:"Internet connection not available!", preferredStyle: UIAlertControllerStyle.alert)
        //    let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
        //{
        //    (alert:UIAlertAction!) -> Void in
        //    })
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:
        {
            (alert:UIAlertAction!) -> Void in
        })
        //alert.addAction(okAction)
        alert.addAction(cancelAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
extension UIButton
{
    func SetShadow()
    {
        backgroundColor = UIColor.white
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.1
        layer.shadowColor = UIColor(red: 225.0 / 255.0, green: 228.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
    }
}
extension UIView
{
    func SetViewShadow()
    {
        backgroundColor = UIColor.white
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0.1
        layer.shadowColor = UIColor(red: 225.0 / 255.0, green: 228.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
    }
}
extension UIColor
{
    static var random: UIColor
    {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
extension CGFloat
{
    static var random: CGFloat
    {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
//Activicty indicator extences here.......
extension UIViewController{
    func START_INDICATOR()
    {
        let setSize = CGSize(width: 60, height: 60)
        let Msg = "Loading..."
        let Font = UIFont(name: "Helvetica Neue", size: 15.0)
        let Back = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let Act = ActivityData(size: setSize, message: Msg, messageFont: Font, type: .ballClipRotateMultiple, color: .white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: Back, textColor: .white)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(Act)
    }
    
    func STOP_INDICATOR()
    {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}

extension UITableViewCell
{
    func SetON()
    {
        let setSize = CGSize(width: 60, height: 60)
        let Msg = "Loading..."
        let Font = UIFont(name: "Helvetica Neue", size: 15.0)
        let Back = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let Act = ActivityData(size: setSize, message: Msg, messageFont: Font, type: .ballClipRotateMultiple, color: .white, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: Back, textColor: .white)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(Act)
    }
    func SetOFF()
    {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
extension UIViewController
{
    func ShowAlert()
{
    let alert = UIAlertController(title: "Odin App", message:"Under Development", preferredStyle: UIAlertControllerStyle.alert)
//    let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
//{
//    (alert:UIAlertAction!) -> Void in
//    })
    let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:
{
    (alert:UIAlertAction!) -> Void in
    })
    //alert.addAction(okAction)
    alert.addAction(cancelAction)
    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    alertWindow.makeKeyAndVisible()
    alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }

}

extension UIViewController
{
    func ShowAlertForPermission()
    {
        let alert = UIAlertController(title: "Odin App", message:"Permission denied", preferredStyle: UIAlertControllerStyle.alert)
        //    let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler:
        //{
        //    (alert:UIAlertAction!) -> Void in
        //    })
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler:
        {
            (alert:UIAlertAction!) -> Void in
        })
        //alert.addAction(okAction)
        alert.addAction(cancelAction)
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func saveToCameraRoll(image: UIImage, completion: @escaping (URL?) -> Void) {
        var placeHolder: PHObjectPlaceholder? = nil
        PHPhotoLibrary.shared().performChanges({
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            placeHolder = creationRequest.placeholderForCreatedAsset!
        }, completionHandler: { success, error in
            guard success, let placeholder = placeHolder else {
                completion(nil)
                return
            }
            let assets = PHAsset.fetchAssets(withLocalIdentifiers: [placeholder.localIdentifier], options: nil)
            guard let asset = assets.firstObject else {
                completion(nil)
                return
            }
            asset.requestContentEditingInput(with: nil, completionHandler: { (editingInput, _) in
                completion(editingInput?.fullSizeImageURL)
            })
        })
    }
    
}

extension UIView
{
    
    @IBInspectable var cornerRadiusView: CGFloat
        {
        
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidthView: CGFloat
        {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColorView: UIColor?
        {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = borderColorView?.cgColor
        }
    }
}


extension UIApplication {
    
    /*
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController
        {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController
        {
            if let selected = tab.selectedViewController
            {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController
        {
            return topViewController(presented)
        }
        
        if let slide = viewController as? SlideMenuController
        {
            return topViewController(slide.mainViewController)
        }
        return viewController
    }
 */
}
func Badge(Value: UILabel)
{
    let label = UILabel(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
    label.layer.borderColor = UIColor.clear.cgColor
    label.layer.borderWidth = 2
    label.layer.cornerRadius = label.bounds.size.height / 2
    label.textAlignment = .center
    label.layer.masksToBounds = true
    //        label.font = UIFont(name: "SanFranciscoText-Light", size: 5)
    label.textColor = .white
    label.backgroundColor = .red
//    label.text = Value
}

//var name12:String
//var mimeType:String
//var fileName12:String
//var url:NSURL?
//var data:NSData?
//
//init( name: String, withFileURL url: NSURL, withMimeType mimeType: String? = nil )
//{
//    self.name12 = name
//    self.url = url
//    self.fileName12 = name
//    self.mimeType = "application/octet-stream"
//    if mimeType != nil {
//        self.mimeType = mimeType!
//    }
//    if let _name = url.lastPathComponent {
//        fileName12 = _name
//    }
//    if mimeType == nil, let _extension = url.pathExtension {
//        switch _extension.lowercased() {
//            
//        case "jpeg", "jpg":
//            self.mimeType = "image/jpeg"
//            
//        case "png":
//            self.mimeType = "image/png"
//            
//        default:
//            self.mimeType = "application/octet-stream"
//        }
//    }
//}

/**
A TextFieldEffects object is a control that displays editable text and contains the boilerplates to setup unique animations for text entrey and display. You typically use this class the same way you use UITextField.
*/
open class TextFieldEffects : UITextField {
    
    /**
    UILabel that holds all the placeholder information
    */
    open let placeholderLabel = UILabel()
    
    /**
    Creates all the animations that are used to leave the textfield in the "entering text" state.
    */
    open func animateViewsForTextEntry() {
        fatalError("\(#function) must be overridden")
    }
    
    /**
    Creates all the animations that are used to leave the textfield in the "display input text" state.
    */
    open func animateViewsForTextDisplay() {
        fatalError("\(#function) must be overridden")
    }
    
    /**
    Draws the receiver’s image within the passed-in rectangle.
    
    - parameter rect:	The portion of the view’s bounds that needs to be updated.
    */
    open func drawViewsForRect(_ rect: CGRect) {
        fatalError("\(#function) must be overridden")
    }
    
    open func updateViewsForBoundsChange(_ bounds: CGRect) {
        fatalError("\(#function) must be overridden")
    }
    
    // MARK: - Overrides
    
    override open func draw(_ rect: CGRect) {
        drawViewsForRect(rect)
    }
    
    override open func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    override open var text: String? {
        didSet {
            if let text = text, text.isNotEmpty {
                animateViewsForTextEntry()
            } else {
                animateViewsForTextDisplay()
            }
        }
    }
    
    // MARK: - UITextField Observing
    
    override open func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(TextFieldEffects.textFieldDidEndEditing), name:NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
            
            NotificationCenter.default.addObserver(self, selector: #selector(TextFieldEffects.textFieldDidBeginEditing), name:NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    /**
    The textfield has started an editing session.
    */
    open func textFieldDidBeginEditing() {
        animateViewsForTextEntry()
    }
    
    /**
    The textfield has ended an editing session.
    */
    open func textFieldDidEndEditing() {
        animateViewsForTextDisplay()
    }
    
    // MARK: - Interface Builder
    
    override open func prepareForInterfaceBuilder() {
        drawViewsForRect(frame)
    }
}
