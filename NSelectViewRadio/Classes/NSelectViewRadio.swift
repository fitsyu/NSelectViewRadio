//
//  DefaultNSelectView.swift
//  NSelect
//
//  Created by iOSDev on 13/06/19.
//
import NSelect
import UIRadioButton

public class NSelectViewRadio: UIView, NSelectView {
    
    public var backing: NSelect = NSelect()
    
    public var delegate: NSelectViewDelegate?
    
    private var radioButtons = UIRadioButtonGroup()
    
    private var optionViews: [UIRadioButton:String] = [:]
    
    public func present() {
        

        var y = 0

        let label = UILabel(frame: CGRect(x: 0, y: y, width: 100, height: 30))
        label.text = backing.title

        y += 30
        self.addSubview(label)

        backing.options.forEach {
            let label = UILabel(frame: CGRect(x: 50, y: y, width: 100, height: 30))
            label.text = $0

            y += 30
            self.addSubview(label)


            let rb = UIRadioButton()
            rb.frame.size   = CGSize(width: 30, height: 30)
            rb.frame.origin = label.frame.origin.applying(
                CGAffineTransform(translationX: -50, y: 0))
            self.addSubview(rb)

            rb.addTarget(self, action: #selector(updateSelections(_:)), for: .valueChanged)

            if backing.mode == .single {
                // draw radio buttons
                radioButtons.add(rb)
            } else {
                // draw checkboxes

            }

            self.optionViews[rb] = $0
        }
        
        
        //
        //
        //
        //        let op1 = makeOptionView(title: "Hello")
        //        let op2 = makeOptionView(title: "World")
        //
        //        let stackView = UIStackView(frame: CGRect(x: 0, y: 40,
        //                                                  width: self.frame.width,
        //                                                  height: self.frame.height))
        //        stackView.axis = .vertical
        //        stackView.alignment = .leading
        //        stackView.spacing = 8
        //        stackView.backgroundColor = UIColor.groupTableViewBackground
        //
        //        stackView.addArrangedSubview(op1)
        //        stackView.addArrangedSubview(op2)
        //
        //        self.addSubview(stackView)
    }
    
    //    private func makeOptionView(title: String) -> UIStackView  {
    //
    //        let stackView = UIStackView()
    //        stackView.axis = .horizontal
    //        stackView.spacing = 8
    //        stackView.alignment = .fill
    //
    //        let radioButton = UIRadioButton()
    //        radioButton.frame.size = CGSize(width: 30, height: 30)
    //        radioButton.tintColor = UIColor.blue
    //
    //        let label = UILabel()
    //        label.text = title
    //        label.sizeToFit()
    //
    //        stackView.frame.size = CGSize(width: 30 + 8 + label.frame.size.width ,
    //            height: label.frame.size.height)
    //
    //        stackView.addArrangedSubview(radioButton)
    //        stackView.addArrangedSubview(label)
    //
    //        return stackView
    //    }
    
    @objc func updateSelections(_ sender: UIRadioButton) {
        
        if let option = self.optionViews[sender] {
            if sender.isSelected {
                backing.select(option: option)
            } else {
                backing.deselect(option: option)
            }
        }
    }
    
    
}


