//
//  TwitterLoginVC.swift
//  Twitter Counter
//
//  Created by KhaleD HuSsien on 24/09/2025.
//

import UIKit

class TwitterLoginVC: UIViewController {
    @IBOutlet weak var twitterLoginBtn: UIButton!
    let twitterClient = TwitterClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        twitterLoginBtn.layer.cornerRadius = 12
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        twitterLogin()
    }
    func twitterLogin(){
        twitterClient.login { success, credential in
            if success {
                self.showToast(message: "Login Success ✅", bgColor: UIColor(named: "GreenColor")!)
                self.goToTwitterHomeVC(with: self.twitterClient)
            } else {
                self.showToast(message: "Login Failed ❌", bgColor: .red)
            }
        }
        
    }
    private func goToTwitterHomeVC(with client: TwitterClient){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TwitterHomeViewController") as? TwitterHomeViewController {
            vc.twitterClient = client
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

