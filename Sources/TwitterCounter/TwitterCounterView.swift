//
//  TwitterCounter.swift
//  Twitter Counter Sample App
//
//  Created by Mah on 20/09/2023.
//

import UIKit
import MobileCoreServices

public class TwitterCounterView: UIView {
    
    @IBOutlet private weak var charactersTypedView: CharacterCountView!
    @IBOutlet private weak var charactersRemainingView: CharacterCountView!
    @IBOutlet private weak var tweetTextView: UITextView!
    @IBOutlet private weak var clearTextBtn: UIButton!
    @IBOutlet private weak var copyTextBtn: UIButton!
    @IBOutlet private weak var postTweetBtn: UIButton!
    
    private let controller: PTwitterCounterController = TwitterCounterController()
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "TwitterCounterView", bundle: Bundle.module)
        
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
        }
        
        initUi()
    }
    
    private func initUi() {
        
        charactersTypedView.setTitle("Characters Typed")
        charactersTypedView.setContent(controller.getCharactersTypedContent())
        
        charactersRemainingView.setTitle("Characters Remaining")
        charactersRemainingView.setContent(controller.getCharactersRemainingContent())
        
        updateBtns(false)
        
        tweetTextView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        tweetTextView.delegate = self
        tweetTextView.textColor = UIColor.lightGray
        tweetTextView.layer.cornerRadius = 12
        tweetTextView.layer.borderWidth = 1
        tweetTextView.layer.borderColor = UIColor(rgb: 0xFFEDEDED).cgColor
        tweetTextView.text = controller.getTweetPlaceHolder()
    }
    
    @IBAction
    func didTapClearText(_ sender: UIButton) {
        tweetTextView.text = nil
        endEditing(true)
        updateBtns(false)
        controller.updateCharactersCount("")
        updateCharacterCounts()
        textViewDidEndEditing(tweetTextView)
    }
    
    @IBAction
    func didTapCopyText(_ sender: UIButton) {
        controller.copyText(tweetTextView.text ?? "")
    }
    
    @IBAction
    func didTapPostTweet(_ sender: UIButton) {
        controller.postTweet(tweetTextView.text ?? "")
    }
    
    private func updateBtns(_ isEnabled: Bool) {
        clearTextBtn.isEnabled = isEnabled
        copyTextBtn.isEnabled = isEnabled
        postTweetBtn.isEnabled = isEnabled
    }
    
    private func updateCharacterCounts() {
        charactersTypedView.setContent(controller.getCharactersTypedContent())
        charactersRemainingView.setContent(controller.getCharactersRemainingContent())
    }
}

extension TwitterCounterView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
    }
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = controller.getTweetPlaceHolder()
            textView.textColor = UIColor.lightGray
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        controller.updateCharactersCount(textView.text)
        updateBtns(controller.shouldEnableBtns())
        updateCharacterCounts()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 280
    }
}
