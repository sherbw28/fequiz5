//
//  SelectQuizViewController.swift
//  FEQuiz
//
//  Created by 佐藤栄祐 on 2022/01/15.
//

import UIKit
import GoogleMobileAds

class SelectQuizViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var selectQuiz1: UIButton!
    @IBOutlet var selectQuiz2: UIButton!
    @IBOutlet var selectQuiz3: UIButton!
    @IBOutlet var selectQuiz4: UIButton!
    
    
    var selectTag = 0
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "問題の種類を選択して下さい"
        titleLabel.textColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0)
        
        selectQuiz1.layer.cornerRadius = 10.0
        selectQuiz2.layer.cornerRadius = 10.0
        selectQuiz3.layer.cornerRadius = 10.0
        selectQuiz4.layer.cornerRadius = 10.0
        selectQuiz1.layer.borderWidth = 2
        selectQuiz2.layer.borderWidth = 2
        selectQuiz3.layer.borderWidth = 2
        selectQuiz4.layer.borderWidth = 2
        selectQuiz1.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        selectQuiz2.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        selectQuiz3.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        selectQuiz4.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        selectQuiz1.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        selectQuiz2.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        selectQuiz3.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        selectQuiz4.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizVC = segue.destination as! QuizTestViewController
        quizVC.selectQuiz = selectTag
    }
    
    @IBAction func selectQuizButtonAction(sender: UIButton) {
        selectTag = sender.tag
        performSegue(withIdentifier: "toQuizVC", sender: nil)
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
