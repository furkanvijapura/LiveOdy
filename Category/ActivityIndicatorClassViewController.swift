//
//  ActivityIndicatorClassViewController.swift
//  Odin_App_Project_Swift
//
//  Created by discussolutions on 9/12/17.
//  Copyright © 2017 discussolutions. All rights reserved.
//

import UIKit

let messageFrame = UIView()
var activityIndicator = UIActivityIndicatorView()
var strLabel = UILabel()
let effectView = UIVisualEffectView(effect: UIBlurEffect(style:.extraLight))

extension  UIViewController
{
    func INDISTART() {
//
//        strLabel.removeFromSuperview()
//        activityIndicator.removeFromSuperview()
//        effectView.removeFromSuperview()
//
//        strLabel            = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 60))
//        strLabel.text       = "Processing..."
//        strLabel.font       = UIFont.systemFont(ofSize: 15, weight: UIFontWeightHeavy)
//       strLabel.textColor = UIColor(red: 0/255, green: 130/255, blue: 164/255, alpha: 1.0)
//
////        strLabel.textColor  = UIColor(white: 0.9, alpha: 0.9)
//
//        effectView.frame    = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 170, height: 60)
//        effectView.layer.cornerRadius = 10
//        effectView.layer.masksToBounds = true
////        effectView.backgroundColor = UIColor(red: 0/255, green: 130/255, blue: 164/255, alpha: 1.0)
//        effectView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
//
//        activityIndicator       = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 60)
//        activityIndicator.color = UIColor(red: 0/255, green: 130/255, blue: 164/255, alpha: 1.0)
//        activityIndicator.startAnimating()
//
//        effectView.addSubview(activityIndicator)
//        effectView.addSubview(strLabel)
//        view.addSubview(effectView)
//        self.view.isUserInteractionEnabled = false
        
        
    }
    func INDISTOP()
    {
//        self.view.isUserInteractionEnabled = true
//        messageFrame.isHidden = true
//        strLabel.isHidden = true
//        effectView.isHidden = true
    }
}

