//
//  QuizViewController.swift
//  FEQuiz
//
//  Created by 佐藤栄祐 on 2022/01/13.
//

import UIKit
import GoogleMobileAds

class QuizViewController: UIViewController {
    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet var whenThisQuiz: UILabel!
    @IBOutlet var judgeImageView: UIImageView!
    
    var bannerView: GADBannerView!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
        
        csvArray = loadCSV(fileName: "quiz")
//        csvArray.shuffle()
        
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        quizNumberLabel.text = "第\(quizCount + 1)問"
        whenThisQuiz.text = quizArray[6]
        quizTextView.text = "問題   \(quizArray[0])\n\n\nア　\(quizArray[2])\n\n\nイ　\(quizArray[3])\n\n\nウ　\(quizArray[4])\n\n\nエ　\(quizArray[5])"
        
        answerButton1.layer.cornerRadius = 10.0
        answerButton2.layer.cornerRadius = 10.0
        answerButton3.layer.cornerRadius = 10.0
        answerButton4.layer.cornerRadius = 10.0
        
        greenAll()
        
        answerButton1.layer.borderWidth = 2
        answerButton2.layer.borderWidth = 2
        answerButton3.layer.borderWidth = 2
        answerButton4.layer.borderWidth = 2

        // Do any additional setup after loading the view.
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let scoreVC = segue.destination as! ScoreViewController
        scoreVC.correct = correctCount
    }
    
    @IBAction func btnActoin(sender: UIButton) {
        if sender.tag == Int(quizArray[1]) {
            correctCount += 1
            judgeImageView.image = UIImage(named: "correct")
            
            if Int(quizArray[1]) == 1 {
                gray1()
                
            }else if Int(quizArray[1]) == 2{
                gray2()

            }else if Int(quizArray[1]) == 3{
                gray3()
                
            }else if Int(quizArray[1]) == 4{
                gray4()
                
            }
        }else {
            if Int(quizArray[1]) == 1 {
                answerButton1.layer.borderColor = UIColor.red.cgColor
                answerButton1.setTitleColor(UIColor.red, for: .normal)
                
                gray1()
            }else if Int(quizArray[1]) == 2 {
                answerButton2.layer.borderColor = UIColor.red.cgColor
                answerButton2.setTitleColor(UIColor.red, for: .normal)
                
                gray2()
            }else if Int(quizArray[1]) == 3 {
                answerButton3.layer.borderColor = UIColor.red.cgColor
                answerButton3.setTitleColor(UIColor.red, for: .normal)
                
                gray3()
            }else {
                answerButton4.layer.borderColor = UIColor.red.cgColor
                answerButton4.setTitleColor(UIColor.red, for: .normal)
                
                gray4()
            }
            judgeImageView.image = UIImage(named: "incorrect")
        }
        
        judgeImageView.isHidden = false
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.greenAll()
            
            self.judgeImageView.isHidden = true
            self.answerButton1.isEnabled = true
            self.answerButton2.isEnabled = true
            self.answerButton3.isEnabled = true
            self.answerButton4.isEnabled = true
            self.nextQuiz()
//            csvArray.count
        }
    }
    
    func nextQuiz() {
        quizCount += 1
        
        if quizCount < 10 {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            whenThisQuiz.text = quizArray[6]
            quizTextView.text = "問題     \(quizArray[0])\n\n\nア　\(quizArray[2])\n\n\nイ　\(quizArray[3])\n\n\nウ　\(quizArray[4])\n\n\nエ　\(quizArray[5])"
        } else {
           performSegue(withIdentifier: "toScoreVC", sender: nil)
        }
    }
    
    func loadCSV(fileName: String) -> [String] {
        let csvBundle = Bundle.main.path(forResource: fileName, ofType: "csv")!
        do {
            let csvData = try String(contentsOfFile: csvBundle, encoding: String.Encoding.utf8)
            let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
            csvArray = lineChange.components(separatedBy: "\n")
            csvArray.removeLast()
        } catch {
            print("エラー")
        }
        return csvArray
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
    
    func gray1() {
        answerButton2.setTitleColor(UIColor.gray, for: .normal)
        answerButton3.setTitleColor(UIColor.gray, for: .normal)
        answerButton4.setTitleColor(UIColor.gray, for: .normal)
        answerButton2.layer.borderColor = UIColor.gray.cgColor
        answerButton3.layer.borderColor = UIColor.gray.cgColor
        answerButton4.layer.borderColor = UIColor.gray.cgColor
    }
    
    func gray2() {
        answerButton1.setTitleColor(UIColor.gray, for: .normal)
        answerButton3.setTitleColor(UIColor.gray, for: .normal)
        answerButton4.setTitleColor(UIColor.gray, for: .normal)
        answerButton1.layer.borderColor = UIColor.gray.cgColor
        answerButton3.layer.borderColor = UIColor.gray.cgColor
        answerButton4.layer.borderColor = UIColor.gray.cgColor
    }
    
    func gray3() {
        answerButton1.setTitleColor(UIColor.gray, for: .normal)
        answerButton2.setTitleColor(UIColor.gray, for: .normal)
        answerButton4.setTitleColor(UIColor.gray, for: .normal)
        answerButton1.layer.borderColor = UIColor.gray.cgColor
        answerButton2.layer.borderColor = UIColor.gray.cgColor
        answerButton4.layer.borderColor = UIColor.gray.cgColor
    }
    
    func gray4() {
        answerButton1.setTitleColor(UIColor.gray, for: .normal)
        answerButton2.setTitleColor(UIColor.gray, for: .normal)
        answerButton3.setTitleColor(UIColor.gray, for: .normal)
        answerButton1.layer.borderColor = UIColor.gray.cgColor
        answerButton2.layer.borderColor = UIColor.gray.cgColor
        answerButton3.layer.borderColor = UIColor.gray.cgColor
    }
    
    func greenAll() {
//        self.answerButton1.layer.borderColor = UIColor.tintColor.cgColor
//        self.answerButton2.layer.borderColor = UIColor.tintColor.cgColor
//        self.answerButton3.layer.borderColor = UIColor.tintColor.cgColor
//        self.answerButton4.layer.borderColor = UIColor.tintColor.cgColor
//        self.answerButton1.setTitleColor(UIColor.tintColor, for: .normal)
//        self.answerButton2.setTitleColor(UIColor.tintColor, for: .normal)
//        self.answerButton3.setTitleColor(UIColor.tintColor, for: .normal)
//        self.answerButton4.setTitleColor(UIColor.tintColor, for: .normal)
        self.answerButton1.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        self.answerButton2.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        self.answerButton3.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        self.answerButton4.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        self.answerButton1.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        self.answerButton2.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        self.answerButton3.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        self.answerButton4.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
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
