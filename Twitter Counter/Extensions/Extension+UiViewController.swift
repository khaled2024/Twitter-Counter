//
//  Extension+UiViewController.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 22/09/2025.
//

import UIKit

extension UIViewController {
    func showToast(message: String,
                   duration: TimeInterval = 2.0,
                   bgColor:UIColor = UIColor.black.withAlphaComponent(0.8)) {
        
        let toastLabel = PaddingLabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = bgColor
        toastLabel.textColor = .white
        toastLabel.font = .DINNextArabic.bold(size: 16)

        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        
        let maxWidth = self.view.frame.width - 40
        let size = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: .greatestFiniteMagnitude))
        toastLabel.frame = CGRect(
            x: 20,
            y: self.view.frame.height,
            width: maxWidth,
            height: size.height + 20
        )
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
            toastLabel.frame.origin.y = self.view.frame.height - toastLabel.frame.height - 40
        }
        
        UIView.animate(withDuration: 0.4, delay: duration, options: .curveEaseIn, animations: {
            toastLabel.frame.origin.y = self.view.frame.height
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}

class PaddingLabel: UILabel {
    var inset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + inset.left + inset.right,
                      height: size.height + inset.top + inset.bottom)
    }
}
