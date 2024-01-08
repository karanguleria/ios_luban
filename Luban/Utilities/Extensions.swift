//
//  Extensions.swift
//  Noosphere
//
//  Created by King on 12/23/19.
//  Copyright © 2019 Karan. All rights reserved.
//

import UIKit
import GoogleMaps
extension String {
    var isValidName : Bool {
        let emailRegEx = "^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$"
        let range = self.range(of: emailRegEx, options:.regularExpression)
        return range != nil ? true : false
    }
    
    var isBlank : Bool {
        return (self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    //MARK:- Check Valid Email Method
    func isValidEmail() -> Bool  {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return (self.range(of: emailRegEx, options:.regularExpression) != nil)
    }
    //MARK:- Check Valid Email Method
   func isValidPassword() -> Bool {
        guard self != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", ".{6,}")
        return passwordTest.evaluate(with: self)
    }
    
    
}
extension String {

    var htmlToAttributedString: NSAttributedString? {
        guard
            let data = self.data(using: .utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [
                NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
                NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UITextField{
    
    func goToNextTextFeild(nextTextFeild:UITextField){
        self.resignFirstResponder()
        nextTextFeild.becomeFirstResponder()
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
extension UIViewController {
    
    func push(identifier: String, titleVal: String = "", isAnimate:Bool = true) {
        DispatchQueue.main.async {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier)
            controller!.title = titleVal
            self.navigationController?.pushViewController(controller!, animated: isAnimate)
        }
    }
   
    func present(identifier: String, isAnimate:Bool = true) {
        DispatchQueue.main.async {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier)
            self.navigationController?.present(controller!, animated: isAnimate)
        }
    }
    
    func pop(isAnimate:Bool = true) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: isAnimate)
        }
    }
    
    func popToRoot() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func presentLoginAlert(){
        let alertController = UIAlertController(title: "Alert", message: "Please login to continue", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            self.root(identifier: "LoginVC")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func root(identifier: String) {
        DispatchQueue.main.async {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: identifier)
            self.view.window?.rootViewController = controller
        }
    }
    func rootWithDrawer(identifier: String, titleVal: String = "") -> Void {
       let mainViewController =  self.storyboard?.instantiateViewController(withIdentifier:identifier)
        mainViewController?.title = titleVal
        let navigation = UINavigationController(rootViewController: mainViewController!)
        navigation.navigationBar.isHidden = true
        let sideViewController =  self.storyboard?.instantiateViewController(withIdentifier: "DrawerVC")
        let slideMenuController = SlideMenuController.init(mainViewController: navigation, leftMenuViewController: sideViewController!)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        KAppDelegate.sideMenuVC = slideMenuController
        slideMenuController.title = titleVal
        self.view.window?.rootViewController = slideMenuController
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y:
            locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
extension UIViewController:UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
extension GMSMapView {
    
    func setRegion(sourceLocation: CLLocationCoordinate2D, zoomLevel: Float)  {
        let camera = GMSCameraPosition.camera(withLatitude: sourceLocation.latitude, longitude: sourceLocation.longitude, zoom: zoomLevel)
        self.camera = camera
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
