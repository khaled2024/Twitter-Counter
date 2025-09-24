//
//  ViewController.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 21/09/2025.
//

import UIKit

class TwitterHomeViewController: UIViewController {
    // MARK: - Outelts
    @IBOutlet weak var twitterTextView: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var TypingTextView: UIView!
    @IBOutlet weak var charcterRemainigInnerView: UIView!
    @IBOutlet weak var charcterRemainigOuterView: UIView!
    @IBOutlet weak var charcterTypeInnerView: UIView!
    @IBOutlet weak var charcterTypeOuterView: UIView!
    @IBOutlet weak var typedLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!
    
    let vm = TwitterHomeViewModel()
    var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        twitterTextView.delegate = self
        updateCharacterCount("")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        charcterRemainigInnerView.roundCorners([.bottomRight,.bottomLeft], radius: 12)
        charcterTypeInnerView.roundCorners([.bottomRight,.bottomLeft], radius: 12)
    }
    // MARK: - Funcs
    private func setUp(){
        postBtn.layer.cornerRadius = 16
        clearBtn.layer.cornerRadius = 16
        copyBtn.layer.cornerRadius = 16
        charcterTypeOuterView.layer.cornerRadius = 12
        charcterRemainigOuterView.layer.cornerRadius = 12
        
        TypingTextView.layer.cornerRadius = 12
        TypingTextView.layer.borderWidth = 1
        TypingTextView.layer.borderColor = UIColor(named: "ViewBorderColor")?.cgColor
        
        self.navigationController?.navigationBar.isHidden = true
        
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor(named: "BlueColor")
        view.addSubview(activityIndicator)
    }
    private func postTweet(){
        guard let text = twitterTextView.text, !text.isEmpty else { return }
        activityIndicator.startAnimating()
        vm.postTweet(text: text) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.activityIndicator.stopAnimating()
                switch result {
                case .success(_):
                    self.showToast(message: "Posted Successfully🎉",
                                   bgColor: UIColor(named: "BlueColor")!)
                    self.activityIndicator.stopAnimating()
                case .failure(let error):
                    self.showToast(message: "Error: \(error.localizedDescription)",
                                   bgColor: .red)
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    private func updateCharacterCount(_ text: String) {
        let result = vm.countCharacters(text)
        
        typedLabel.text = "\(result.count)/280"
        remainingLabel.text = "\(result.remaining)"
        
        if result.isValid {
            typedLabel.textColor = .black
            remainingLabel.textColor = .black
            postBtn.isEnabled = true
        } else {
            typedLabel.textColor = .red
            remainingLabel.textColor = .red
            postBtn.isEnabled = false
        }
    }
    // MARK: - Actions
    @IBAction func copyTapped(_ sender: UIButton) {
        vm.copyText(twitterTextView.text)
        self.showToast(message: "Copied Successfully🎉", bgColor: UIColor(named: "GreenColor")!)
    }
    @IBAction func clearTapped(_ sender: UIButton) {
        twitterTextView.text = vm.clearText()
        updateCharacterCount("")
        self.showToast(message: "Deleted Successfully🎉", bgColor: UIColor(named: "RedColor")!)
    }
    @IBAction func postTapped(_ sender: UIButton) {
        postTweet()
    }
    @IBAction func logoutTapped(_ sender: UIButton) {
        vm.logout()
    }
}
// MARK: - TextView
extension TwitterHomeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCharacterCount(textView.text)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        let result = vm.countCharacters(updatedText)
        return result.isValid
    }
}

