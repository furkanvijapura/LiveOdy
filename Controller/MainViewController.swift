//
//  ViewController.swift
//  17
//
//  Created by Discus IT on 22/08/17.
//  Copyright © 2017 Discus IT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("MainViewController")
        self.setNavigationBarItem()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func Go_act(_ sender: Any)
    {
        let next = storyboard?.instantiateViewController(withIdentifier: "shareViewController")as! shareViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}


