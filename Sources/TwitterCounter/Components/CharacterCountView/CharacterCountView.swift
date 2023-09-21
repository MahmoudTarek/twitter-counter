//
//  CharacterCountView.swift
//  Twitter Counter Sample App
//
//  Created by Mah on 20/09/2023.
//

import UIKit

class CharacterCountView: UIView {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "CharacterCountView", bundle: nil)
        
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
        
        initUi()
    }
    
    private func initUi() {
        containerView.layer.cornerRadius = 12
        containerView.layer.borderColor = UIColor(rgb: 0xFFE6F6FE).cgColor
        containerView.layer.borderWidth = 2
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setContent(_ text: String) {
        contentLabel.text = text
    }
}
