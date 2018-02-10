//
//  GameScreenViewController.swift
//  MatchTheMembers
//
//  Created by Shubham Gupta on 2/7/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class GameScreenViewController: UIViewController {

    var memberPicture: UIImage!
    var nameOptions = [String]()
    var score = 0
    var topLeftButton: UIButton!
    var topRightButton: UIButton!
    var bottomLeftButton: UIButton!
    var bottomRightButton: UIButton!
    var statsButton: UIButton!
    var stopButton: UIButton!
    var scoreLabel: UILabel!
    var timerLabel: UILabel!
    var seconds = 5
    var timer = Timer()
    var isTimerRunning = false
    var answer: String!
    var options: [String]!
    var option1: String!
    var option2: String!
    var option3: String!
    var option4: String!
    var memberPictureView: UIImageView!
    var backgroundColours = [UIColor()]
    var backgroundLoop = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        responses = [" ", " ", " "]
        timerLabel = UILabel(frame: CGRect(x: view.frame.width - 170, y:610, width: 150, height: 40))
        
        view.addSubview(timerLabel)
        
        let stats = UIButton(type: .custom)
        stats.setImage(UIImage(named: "statslogo"), for: .normal)
        //btn1.setTitle("Stats", for: .normal)
        stats.frame = CGRect(x: view.frame.width - 50, y: 0, width: 30, height: 20)
        stats.addTarget(self, action: #selector(segueToStats), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: stats)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        stopButton = UIButton(frame: CGRect(x: view.frame.midX - 50, y:370, width:100, height: 60))
        stopButton.setTitle("STOP!", for: .normal)
        stopButton.titleLabel?.textAlignment = .center
        stopButton.addTarget(self, action: #selector(unwindToMainScreen), for: .touchUpInside)
        stopButton.titleLabel?.font = UIFont (name: "HoeflerText-Black", size: 25)
        view.addSubview(stopButton)
        
        topLeftButton = UIButton(frame: CGRect(x: 20, y:430, width:view.frame.midX - 30, height: 70))
        topLeftButton.titleLabel?.font = UIFont (name: "HelveticaNeue", size: 17)
        topLeftButton.backgroundColor = UIColor.blue
        topLeftButton.addTarget(self, action: #selector(checkAnswerButtonA), for: .touchUpInside)
        view.addSubview(topLeftButton)
        
        topRightButton = UIButton(frame: CGRect(x: view.frame.midX + 10, y:430, width:view.frame.midX - 30, height: 70))
        topRightButton.titleLabel?.font = UIFont (name: "HelveticaNeue", size: 17)
        topRightButton.backgroundColor = UIColor.blue
        topRightButton.addTarget(self, action: #selector(checkAnswerButtonB), for: .touchUpInside)
        view.addSubview(topRightButton)
        
        bottomLeftButton = UIButton(frame: CGRect(x: 20, y:520, width:view.frame.midX - 30, height: 70))
        bottomLeftButton.titleLabel?.font = UIFont (name: "HelveticaNeue", size: 17)
        bottomLeftButton.backgroundColor = UIColor.blue
        bottomLeftButton.addTarget(self, action: #selector(checkAnswerButtonC), for: .touchUpInside)
        view.addSubview(bottomLeftButton)
        
        bottomRightButton = UIButton(frame: CGRect(x: view.frame.midX + 10, y:520, width:view.frame.midX - 30, height: 70))
        bottomRightButton.titleLabel?.font = UIFont (name: "HelveticaNeue", size: 17)
        bottomRightButton.addTarget(self, action: #selector(checkAnswerButtonD), for: .touchUpInside)
        view.addSubview(bottomRightButton)
        
        scoreLabel = UILabel(frame: CGRect(x: 20, y:610, width: 100, height: 40))
        scoreLabel.text = "Score: \(score)"
        scoreLabel.font =  UIFont (name: "HelveticaNeue-Thin", size: 20)
        view.addSubview(scoreLabel)
        
        let lightBlue = UIColor(hue: 0.5667, saturation: 0.58, brightness: 0.96, alpha: 1.0)
        let midBlue = UIColor(hue: 0.5667, saturation: 0.72, brightness: 0.96, alpha: 1.0)
        let darkBlue = UIColor(hue: 0.5667, saturation: 0.82, brightness: 0.96, alpha: 1.0)
        backgroundColours = [lightBlue, midBlue, darkBlue]
        backgroundLoop = 0
        self.animateBackgroundColour()
        
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        options = createOptions()
        answer = selectAnswer(options: options)
        
        print("answer is \(answer)")
        memberPictureView = findImages(name: answer)
        memberPictureView.frame = CGRect(x:20, y:60, width: view.frame.width - 40, height: 300)
        view.addSubview(memberPictureView)
        
        option1 = options[0]
        option2 = options[1]
        option3 = options[2]
        option4 = options[3]
        
        topLeftButton.setTitle(option1, for: .normal)
        topRightButton.setTitle(option2, for: .normal)
        bottomLeftButton.setTitle(option3, for: .normal)
        bottomRightButton.setTitle(option4, for: .normal)
        
        topLeftButton.backgroundColor = UIColor.blue
        topRightButton.backgroundColor = UIColor.blue
        bottomLeftButton.backgroundColor = UIColor.blue
        bottomRightButton.backgroundColor = UIColor.blue

    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(GameScreenViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = "Time Left: 0:0\(seconds)" //This will update the label.
        if seconds == 0 {
            showAnswers()
            timer.invalidate()
            responses.append("Incorrect")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.resetTimer()
                self.setup()
            })
        }
    }
    
    func showAnswers() {
        if option1 == answer {
            topLeftButton.backgroundColor = .green
            topRightButton.backgroundColor = .red
            bottomLeftButton.backgroundColor = .red
            bottomRightButton.backgroundColor = .red
        }
        if option2 == answer {
            topLeftButton.backgroundColor = .red
            topRightButton.backgroundColor = .green
            bottomLeftButton.backgroundColor = .red
            bottomRightButton.backgroundColor = .red
        }
        if option3 == answer {
            topLeftButton.backgroundColor = .red
            topRightButton.backgroundColor = .red
            bottomLeftButton.backgroundColor = .green
            bottomRightButton.backgroundColor = .red
        }
        if option4 == answer {
            topLeftButton.backgroundColor = .red
            topRightButton.backgroundColor = .red
            bottomLeftButton.backgroundColor = .red
            bottomRightButton.backgroundColor = .green
        }
    }
    
    @objc func checkAnswerButtonA() {
        if option1 == answer {
            topLeftButton.backgroundColor = .green
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            scores.append(score)
            responses.append("Correct")
        } else {
            topLeftButton.backgroundColor = .red
            responses.append("Inorrect")
        }
        timer.invalidate()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.resetTimer()
            self.setup()
            self.view.isUserInteractionEnabled = true
        })
        
    }
    
    @objc func checkAnswerButtonB() {
        if option2 == answer {
            topRightButton.backgroundColor = .green
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            scores.append(score)
            responses.append("Correct")
        } else {
            topRightButton.backgroundColor = .red
            responses.append("Incorrect")
        }
        timer.invalidate()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.resetTimer()
            self.view.isUserInteractionEnabled = true
            self.setup()
        })
    }
    
    @objc func checkAnswerButtonC() {
        if option3 == answer {
            bottomLeftButton.backgroundColor = .green
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            scores.append(score)
            responses.append("Correct")
        } else {
            bottomLeftButton.backgroundColor = .red
            responses.append("Incorrect")
        }
        timer.invalidate()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.view.isUserInteractionEnabled = true
            self.resetTimer()
            self.setup()
        })
    }
    
    @objc func checkAnswerButtonD() {
        if option4 == answer {
            bottomRightButton.backgroundColor = .green
            score = score + 1
            scoreLabel.text = "Score: \(score)"
            scores.append(score)
            responses.append("Correct")
        } else {
            bottomRightButton.backgroundColor = .red
            responses.append("Incorrect")
        }
        self.view.isUserInteractionEnabled = false
        timer.invalidate()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.resetTimer()
            self.view.isUserInteractionEnabled = true
            self.setup()
        })
    }

    
    func resetTimer() {
        timer.invalidate()
        seconds = 5    //Here we manually enter the restarting point for the seconds, but it would be wiser to make this a variable or constant.
        timerLabel.text = "Time Left: 0:0\(seconds)"
        runTimer()
    }
    
    func animateBackgroundColour () {
        if backgroundLoop < backgroundColours.count - 1 {
            backgroundLoop += 1
        } else {
            backgroundLoop = 0
        }
        UIView.animate(withDuration: 4, delay: 0.5, options: UIViewAnimationOptions.allowUserInteraction, animations: { () -> Void in
            self.view.backgroundColor =  self.backgroundColours[self.backgroundLoop];
        }) {(Bool) -> Void in
            self.animateBackgroundColour();
        }
    }
    
    @objc func segueToStats() {
        timer.invalidate()
        self.performSegue(withIdentifier: "toStats", sender: self)
    }
    
    @objc func unwindToMainScreen() {
        timer.invalidate()
        responses = ["", "", ""]
        self.performSegue(withIdentifier: "unwindToStart", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false;
        runTimer();
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }

    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        
        //code
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
