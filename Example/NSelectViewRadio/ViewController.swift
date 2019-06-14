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
        
        let aiv = self.view
        aiv!.backgroundColor = UIColor.groupTableViewBackground
        
        let sortQ = NSelect()
        sortQ.title = "Urutkan hasil"
        sortQ.mode = .single
        sortQ.options = ["Jarak", "Harga Terendah", "Ruang Tersedia"]
        sortQ.defaultSelections = ["Jarak"]
        
        
        let frame = CGRect(x: 8, y: 50, width: aiv!.frame.width-16, height: 120)
        let sortQView = NSelectViewRadio(frame: frame)
        sortQView.backing = sortQ
        
        
        aiv!.addSubview(sortQView)
        sortQView.present()
//        sortQView.sizeToFit()
    }
}

