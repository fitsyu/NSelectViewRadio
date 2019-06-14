//
//  OptionViewCell.swift
//  NSelectViewRadio
//
//  Created by iOSDev on 14/06/19.
//

import UIRadioButton

class OptionViewCell: UICollectionViewCell {
    
    static var ID: String = "OptionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var radioButton: UIRadioButton!
    
    struct Data {
        var title: String
        var selected: Bool = false
    }
    
    var meta: Data! {
        didSet {
            titleLabel.text = meta.title
            radioButton.isSelected = meta.selected
        }
    }
}
