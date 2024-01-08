//
//  UIView+CustomMethod.swift
//  Luban
//
//  Created by Ganesh Sharma on 24/03/20.
//

import Foundation
import UIKit

class ViewCustomMethod{
    
    static func setCircleBorder(_ view:UIView){
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.borderWidth = 1
        view.layer.borderColor = Constants.appBaseColor.cgColor
    }
    
    static func setBtnCircleBorder(_ view:UIButton){
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.height / 2
    }
}
