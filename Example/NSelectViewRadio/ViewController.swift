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
        
        let sortQ = NSelect()
        sortQ.title = "Urutkan hasil"
        sortQ.mode = .single
        sortQ.options = ["Jarak", "Harga Terendah", "Ruang Tersedia"]
        sortQ.defaultSelections = ["Jarak"]
        
        
        let frame = CGRect(x: 0, y: 0, width: aiv!.frame.width, height: 0)
        let sortQView = NSelectViewRadio(frame: frame)
        sortQView.backing = sortQ
        
        
        //            print( sortQView.sizeThatFits(aiv!.frame.size) )
        
        aiv!.addSubview(sortQView)
        sortQView.present()
        sortQView.sizeToFit()
    }
}

