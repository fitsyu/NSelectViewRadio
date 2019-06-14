//
//  DefaultNSelectView.swift
//  NSelect
//
//  Created by iOSDev on 13/06/19.
//
import NSelect
import UIRadioButton

public class NSelectViewRadio: UIView, NSelectView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var backing: NSelect = NSelect()
    
    public var delegate: NSelectViewDelegate?
    
    private var radioButtons = UIRadioButtonGroup()
    
    private var optionViews: [UIRadioButton:String] = [:]
    
    
    
    public func present() {
        
        // 0
        let url = Bundle(for: self.classForCoder).url(forResource: "NSelectViewRadio", withExtension: "bundle")
        
        // 1
        let bundle = Bundle(url: url!)
        
        // 2
        let nib = bundle?.loadNibNamed("NSelectViewRadio", owner: self, options: nil)
        
        // 3
        let view = nib?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)

        titleLabel.text = backing.title
        
        setupCollectionView()
        

//        var y = 0
//
//        let label = UILabel(frame: CGRect(x: 0, y: y, width: 100, height: 30))
//        label.text = backing.title
//
//        y += 30
//        self.addSubview(label)
//
//        backing.options.forEach {
//            let label = UILabel(frame: CGRect(x: 50, y: y, width: 100, height: 30))
//            label.text = $0
//
//            y += 30
//            self.addSubview(label)
//
//
//            let rb = UIRadioButton()
//            rb.frame.size   = CGSize(width: 30, height: 30)
//            rb.frame.origin = label.frame.origin.applying(
//                CGAffineTransform(translationX: -50, y: 0))
//            self.addSubview(rb)
//
//            rb.addTarget(self, action: #selector(updateSelections(_:)), for: .valueChanged)
//
//            if backing.mode == .single {
//                // draw radio buttons
//                radioButtons.add(rb)
//            } else {
//                // draw checkboxes
//
//            }
//
//            self.optionViews[rb] = $0
//        }
    }
    
    @objc func updateSelections(_ sender: UIRadioButton) {
        
        if let option = self.optionViews[sender] {
            if sender.isSelected {
                backing.select(option: option)
            } else {
                backing.deselect(option: option)
            }
        }
    }
    
    func setupCollectionView() {
        
        // 0
        let url = Bundle(for: self.classForCoder).url(forResource: "NSelectViewRadio", withExtension: "bundle")
        
        // 1
        let bundle = Bundle(url: url!)
        
        // 2
        let nib = UINib(nibName: "OptionViewCell", bundle: bundle!)
        
        collectionView.register(nib, forCellWithReuseIdentifier: OptionViewCell.ID)
        
        collectionView.dataSource = self
    }
    
}

extension NSelectViewRadio: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backing.options.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionViewCell.ID, for: indexPath) as! OptionViewCell
        
        cell.meta = OptionViewCell.Data(title: backing.options[indexPath.item],
                                        selected: false)
        
        return cell
    }
}


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

