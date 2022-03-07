//
//  QuizTestViewController.swift
//  FEQuiz
//
//  Created by 佐藤栄祐 on 2022/01/14.
//

import UIKit
import GoogleMobileAds

class QuizTestViewController: UIViewController {
    @IBOutlet var quizNumberLabel: UILabel!
    @IBOutlet var quizTextView: UITextView!
    @IBOutlet var answerButton1: UIButton!
    @IBOutlet var answerButton2: UIButton!
    @IBOutlet var answerButton3: UIButton!
    @IBOutlet var answerButton4: UIButton!
    @IBOutlet var whenThisQuiz: UILabel!
    @IBOutlet var judgeImageView: UIImageView!
    @IBOutlet var quizAnswerView: UITextView!
    @IBOutlet var backToQuiz: UIButton!
    @IBOutlet var yourAnswer: UILabel!
    
    var bannerView: GADBannerView!
    
    var csvArray: [String] = []
    var quizArray: [String] = []
    var quizCount = 0
    var correctCount = 0
    var selectQuiz = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/6300978111"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        addBannerViewToView(bannerView)
        
        
        csvArray = loadCSV(fileName: "quiz\(selectQuiz)")
//        csvArray = loadCSV(fileName: "fall30")
        csvArray.shuffle()
        
        quizArray = csvArray[quizCount].components(separatedBy: ",")
        
        quizNumberLabel.text = "第\(quizCount + 1)問"
        whenThisQuiz.text = quizArray[6]
        quizTextView.text = "問題 :    \(quizArray[0])\n\n\nア : 　\(quizArray[2])\n\n\nイ : 　\(quizArray[3])\n\n\nウ : 　\(quizArray[4])\n\n\nエ : 　\(quizArray[5])"
        
        answerButton1.layer.cornerRadius = 10.0
        answerButton2.layer.cornerRadius = 10.0
        answerButton3.layer.cornerRadius = 10.0
        answerButton4.layer.cornerRadius = 10.0
        
        backToQuiz.layer.cornerRadius = 10.0
        backToQuiz.layer.borderWidth = 2
        backToQuiz.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        backToQuiz.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        yourAnswer.isHidden = true
        
        greenAll()
        
        answerButton1.layer.borderWidth = 2
        answerButton2.layer.borderWidth = 2
        answerButton3.layer.borderWidth = 2
        answerButton4.layer.borderWidth = 2
        
        quizAnswerView.isHidden = true
        backToQuiz.isHidden = true

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
        
        if Int(quizArray[1]) == 1 {
            quizAnswerView.text = "正解 : ア\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[2])"
        }else if Int(quizArray[1]) == 2 {
            quizAnswerView.text = "正解 : イ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[3])"
        }else if Int(quizArray[1]) == 3 {
            quizAnswerView.text = "正解 : ウ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[4])"
        }else if Int(quizArray[1]) == 4 {
            quizAnswerView.text = "正解 : エ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[5])"
        }
        
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
            
            if sender.tag == 1 {
                if Int(quizArray[1]) == 1 {
                    quizAnswerView.text = "正解 : ア\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[2])\n\n\n\nあなたの答え :   \(quizArray[2])"
                }else if Int(quizArray[1]) == 2 {
                    quizAnswerView.text = "正解 : イ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[3])\n\n\n\nあなたの答え :   \(quizArray[2])"
                }else if Int(quizArray[1]) == 3 {
                    quizAnswerView.text = "正解 : ウ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[4])\n\n\n\nあなたの答え :   \(quizArray[2])"
                }else if Int(quizArray[1]) == 4 {
                    quizAnswerView.text = "正解 : エ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[5])\n\n\n\nあなたの答え :   \(quizArray[2])"
                }
            }else if sender.tag == 2 {
                if Int(quizArray[1]) == 1 {
                    quizAnswerView.text = "正解 : ア\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[2])\n\n\n\nあなたの答え :   \(quizArray[3])"
                }else if Int(quizArray[1]) == 2 {
                    quizAnswerView.text = "正解 : イ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[3])\n\n\n\nあなたの答え :   \(quizArray[3])"
                }else if Int(quizArray[1]) == 3 {
                    quizAnswerView.text = "正解 : ウ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[4])\n\n\n\nあなたの答え :   \(quizArray[3])"
                }else if Int(quizArray[1]) == 4 {
                    quizAnswerView.text = "正解 : エ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[5])\n\n\n\nあなたの答え :   \(quizArray[3])"
                }
            }else if sender.tag == 3 {
                if Int(quizArray[1]) == 1 {
                    quizAnswerView.text = "正解 : ア\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[2])\n\n\n\nあなたの答え :   \(quizArray[4])"
                }else if Int(quizArray[1]) == 2 {
                    quizAnswerView.text = "正解 : イ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[3])\n\n\n\nあなたの答え :   \(quizArray[4])"
                }else if Int(quizArray[1]) == 3 {
                    quizAnswerView.text = "正解 : ウ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[4])\n\n\n\nあなたの答え :   \(quizArray[4])"
                }else if Int(quizArray[1]) == 4 {
                    quizAnswerView.text = "正解 : エ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[5])\n\n\n\nあなたの答え :   \(quizArray[4])"
                }
            }else if sender.tag == 4 {
                if Int(quizArray[1]) == 1 {
                    quizAnswerView.text = "正解 : ア\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[2])\n\n\n\nあなたの答え :   \(quizArray[5])"
                }else if Int(quizArray[1]) == 2 {
                    quizAnswerView.text = "正解 : イ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[3])\n\n\n\nあなたの答え :   \(quizArray[5])"
                }else if Int(quizArray[1]) == 3 {
                    quizAnswerView.text = "正解 : ウ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[4])\n\n\n\nあなたの答え :   \(quizArray[5])"
                }else if Int(quizArray[1]) == 4 {
                    quizAnswerView.text = "正解 : エ\n\n問題 :   \(quizArray[0])\n\n\n\n答え :   \(quizArray[5])\n\n\n\nあなたの答え :   \(quizArray[5])"
                }
            }
            
        }
        
        if sender.tag == 1 {
            yourAnswer.text = "あなたの答え : ア"
        }else if sender.tag == 2 {
            yourAnswer.text = "あなたの答え : イ"
        }else if sender.tag == 3 {
            yourAnswer.text = "あなたの答え : ウ"
        }else if sender.tag == 4 {
            yourAnswer.text = "あなたの答え : エ"
        }
        
        judgeImageView.isHidden = false
        quizAnswerView.isHidden = false
        backToQuiz.isHidden = false
        backToQuiz.isEnabled = false
        backToQuiz.setTitleColor(UIColor.gray, for: .normal)
        backToQuiz.layer.borderColor = UIColor.gray.cgColor
        yourAnswer.isHidden = false
        
        answerButton1.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        answerButton4.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.judgeImageView.isHidden = true
            self.backToQuiz.isEnabled = true
            self.backToQuiz.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
            self.backToQuiz.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
//            csvArray.count
        }
    }
    
    @IBAction func backToQuizAction(_ sender: Any) {
        self.greenAll()
        
        self.quizAnswerView.isHidden = true
        self.backToQuiz.isHidden = true
        self.yourAnswer.isHidden = true
        
        self.answerButton1.isEnabled = true
        self.answerButton2.isEnabled = true
        self.answerButton3.isEnabled = true
        self.answerButton4.isEnabled = true
        
        self.nextQuiz()
//        csvArray.count
    }
    
    
    func nextQuiz() {
        quizCount += 1
        
        if quizCount < 10 {
            quizArray = csvArray[quizCount].components(separatedBy: ",")
            quizNumberLabel.text = "第\(quizCount + 1)問"
            whenThisQuiz.text = quizArray[6]
            quizTextView.text = "問題 :      \(quizArray[0])\n\n\nア : 　\(quizArray[2])\n\n\nイ : 　\(quizArray[3])\n\n\nウ : 　\(quizArray[4])\n\n\nエ : 　\(quizArray[5])"
        } else {
           performSegue(withIdentifier: "toScoreV", sender: nil)
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

        answerButton1.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        answerButton2.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        answerButton3.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        answerButton4.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
        answerButton1.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        answerButton2.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        answerButton3.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        answerButton4.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        
        backToQuiz.setTitleColor(UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0), for: .normal)
        backToQuiz.layer.borderColor = UIColor(red: 88/255, green: 168/255, blue: 84/255, alpha: 1.0).cgColor
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
