//
//  DefaultNSelectView.swift
//  NSelect
//
//  Created by iOSDev on 13/06/19.
//
import NSelect

public class NSelectViewRadio: UIView, NSelectView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var backing: NSelect = NSelect()
    
    public var delegate: NSelectViewDelegate?
    
    private lazy var bundle: Bundle = {
        
        let url = Bundle(for: self.classForCoder).url(forResource: "NSelectViewRadio", withExtension: "bundle")
        if url == nil {
            print("failed to load bundle")
        }
        
        let bundle = Bundle(url: url!)
        if bundle == nil {
            print("failed to load bundle")
        }
        
        return bundle!
    }()
    
    public func present() {

        // 2
        let nib = bundle.loadNibNamed("NSelectViewRadio", owner: self, options: nil)
        
        // 3
        let view = nib?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)

        titleLabel.text = backing.title
        
        setupCollectionView()
        
        // show default if any
        //  preselectDefaults()
    }
    
    func setupCollectionView() {
        
        let nib = UINib(nibName: "OptionViewCell", bundle: bundle)
        
        collectionView.register(nib, forCellWithReuseIdentifier: OptionViewCell.ID)
        
        collectionView.dataSource = self
        collectionView.delegate   = self
        
        collectionView.allowsMultipleSelection = (backing.mode == .multiple)
    }
    
    
    func preselectDefaults() {
        backing.defaultSelections?.forEach {
            if let idx = backing.options.firstIndex(of: $0) {
                let ip = IndexPath(item: idx, section: 0)
                collectionView.delegate?.collectionView?(collectionView, didSelectItemAt: ip)
            }
        }
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


extension NSelectViewRadio: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let option = backing.options[indexPath.item]
        backing.select(option: option)
        
        let cell = (collectionView.cellForItem(at: indexPath) as! OptionViewCell)
        cell.radioButton.isSelected = true
        
        delegate?.didSelect(self, item: option)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let option = backing.options[indexPath.item]
        backing.deselect(option: option)
        
        let cell = (collectionView.cellForItem(at: indexPath) as! OptionViewCell)
        cell.radioButton.isSelected = false
        
        delegate?.didDeselect(self, item: option)
    }
    
}


// the trickies part
extension NSelectViewRadio: UICollectionViewDelegateFlowLayout {
    

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = backing.options[indexPath.item].size(withAttributes: nil)
        
        let leading: CGFloat = 0
        let radioButtonWidth: CGFloat = 30.0
        let space: CGFloat = 8.0
        let labelWidth: CGFloat = self.frame.size.width * 0.4  //size.width * 2.0 
        let trailing: CGFloat = 8.0
        
        size.width = leading + radioButtonWidth + space + labelWidth + trailing
        size.height = size.height + 20
        
        return size
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
