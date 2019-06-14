//
//  ViewController.swift
//  NSelectViewRadio
//
//  Created by fitsyu on 06/14/2019.
//  Copyright (c) 2019 fitsyu. All rights reserved.
//

import UIKit
import NSelect
import NSelectViewRadio

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // === single ===
        let sortQ = NSelect()
        sortQ.title = "Sort by"
        sortQ.mode = .single
        sortQ.options = ["Distance", "Cheapest", "Availability"]
        sortQ.defaultSelections = ["Jarak"]
        
        let frame = CGRect(x: 8, y: 50, width: view.frame.width-16, height: 120)
        let sortQView = NSelectViewRadio(frame: frame)
        sortQView.backgroundColor = UIColor.red
        sortQView.backing = sortQ
        
        self.view.addSubview(sortQView)
        sortQView.present()
        
        // === multi ===
        let filterQ = NSelect()
        filterQ.title = "Facilites"
        filterQ.mode  = .multiple
        filterQ.options = [ "Living room", "Trees", "Breakfast", "Supermarket", "Carport" ]
        filterQ.defaultSelections = ["Trees", "Carport"]
        
        let frame2 = CGRect(x: 8, y: 50+120+16, width: view.frame.width-16, height: 180)
        let filterQView = NSelectViewRadio(frame: frame2)
        filterQView.backing = filterQ
        
        self.view.addSubview(filterQView)
        filterQView.present()
    }
}

