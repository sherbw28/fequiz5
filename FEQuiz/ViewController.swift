//
//  ViewController.swift
//  FEQuiz
//
//  Created by 佐藤栄祐 on 2022/01/13.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    @IBOutlet var startButton: UIButton!
    @IBOutlet var titleText: UILabel!
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        startButton.layer.cornerRadius = 10.0
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        startButton.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        
        titleText.layer.cornerRadius = 10.0
        titleText.layer.borderWidth = 2
        titleText.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        titleText.textColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0)
        titleText.text = "基本情報午前対策!\nサクッと10問一問一答！"
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                               constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
        ])
    }


}

