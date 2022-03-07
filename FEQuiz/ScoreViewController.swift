//
//  ScoreViewController.swift
//  FEQuiz
//
//  Created by 佐藤栄祐 on 2022/01/13.
//

import UIKit
import GoogleMobileAds

class ScoreViewController: UIViewController {
    
    var correct = 0
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var toTopButton: UIButton!
    
    var bannerView: GADBannerView!
    
    private var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "点数を集計中・・・"
        shareButton.isEnabled = false
        toTopButton.isEnabled = false
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3337536731771878/9157831418",
                                    request: request,
                          completionHandler: { [self] ad, error in
                            if let error = error {
                              print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                              return
                            }
                            interstitial = ad
                          }
        )
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            
            if self.interstitial != nil {
                self.interstitial?.present(fromRootViewController: self)
            } else {
              print("Ad wasn't ready")
            }
            
            if self.correct <= 5 {
                self.scoreLabel.text = "\(self.correct)問正解！\n\n まだまだこれから！\n もう一度挑戦!"
            }else if self.correct <= 8 {
                self.scoreLabel.text = "\(self.correct)問正解！\n\n 合格ライン到達！\n もう一度挑戦!"
            }else if self.correct == 9 {
                self.scoreLabel.text = "\(self.correct)問正解！\n\n 惜しい！あと1点！\n もう一度挑戦!"
            }else if self.correct == 10 {
                self.scoreLabel.text = "\(self.correct)問正解！\n\n すごい！満点！\n もう一度挑戦!"
            }
            
            self.shareButton.layer.cornerRadius = 10.0
            self.toTopButton.layer.cornerRadius = 10.0
            self.shareButton.layer.borderWidth = 2
            self.toTopButton.layer.borderWidth = 2
            self.shareButton.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
            self.toTopButton.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
            self.shareButton.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
            self.toTopButton.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
            
            self.shareButton.isEnabled = true
            self.toTopButton.isEnabled = true
            
//            csvArray.count
        }
        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        let activityItems = ["\(correct)問正解しました!","#1回10問!スキマ時間に応用情報技術者(AP)午前対策!"]
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.present(activityVC, animated: true)
    }
    
    @IBAction func toTopButtonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
