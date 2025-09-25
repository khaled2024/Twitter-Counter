//
//  TwitterLoginVC.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 24/09/2025.
//

import UIKit

class TwitterLoginVC: UIViewController {
    @IBOutlet weak var twitterLoginBtn: UIButton!
    
    @IBOutlet weak var skipSignInBtn: UIButton!
    @IBOutlet weak var twitterLoginView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        twitterLoginView.layer.cornerRadius = 12
        
    }
    @IBAction func skipSignInTapped(_ sender: UIButton) {
        self.goToTwitterHomeVC()
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        twitterLogin()
    }
    private func twitterLogin(){
        TwitterClient.shared.login { success, credential in
            if success {
                self.showToast(message: "Login Success ✅", bgColor: UIColor(named: "GreenColor")!)
                self.goToTwitterHomeVC()
            } else {
                self.showToast(message: "Login Failed ❌", bgColor: .red)
            }
        }
    }
    private func goToTwitterHomeVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TwitterHomeViewController") as? TwitterHomeViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

