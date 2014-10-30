//
//  ViewController.swift
//  ARTCircularSlider
//
//  Created by Artwalk on 10/30/14.
//  Copyright (c) 2014 Artwalk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let cs1 = ARTCircularSlider(frame: view.frame)
        cs1._lineWidth = 6
        view.addSubview(cs1)
        
        let cs2 = ARTCircularSlider(frame: CGRectMake(0, 0, 250, 250))
        cs2.center = view.center
        view.addSubview(cs2)
        cs1.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

