//
//  StatsViewController.swift
//  MatchTheMembers
//
//  Created by Shubham Gupta on 2/8/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    var maxScoreLabel: UILabel!
    var recentsLabel: UILabel!
    var firstRecent: UILabel!
    var secondRecent: UILabel!
    var thirdRecent: UILabel!
    var yourStats: UILabel!
    var backgroundColours = [UIColor()]
    var backgroundLoop = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourStats = UILabel(frame: CGRect(x: 10, y:80, width: view.frame.width - 20, height: 75))
        yourStats.text = "Your Stats"
        yourStats.textAlignment = .center
        yourStats.font =  UIFont (name: "HoeflerText-Black", size: 60)
        view.addSubview(yourStats)
        
        maxScoreLabel = UILabel(frame: CGRect(x: 30, y:180, width: view.frame.width - 60, height: 50))
        maxScoreLabel.text = "Max Score: \(scores.max()!)"
        maxScoreLabel.textAlignment = .center
        maxScoreLabel.font =  UIFont (name: "HelveticaNeue", size: 40)
        view.addSubview(maxScoreLabel)
        
        recentsLabel = UILabel(frame: CGRect(x: 30, y:250, width: view.frame.width - 60, height: 50))
        recentsLabel.text = "Last Three Answers: "
        recentsLabel.textAlignment = .center
        recentsLabel.font =  UIFont (name: "HelveticaNeue", size: 30)
        view.addSubview(recentsLabel)
        
        var recents = lastThree()
        
        firstRecent = UILabel(frame: CGRect(x: 80, y:310, width: view.frame.width - 160, height: 40))
        firstRecent.text = "1. \(recents[0]) "
        firstRecent.font =  UIFont (name: "HelveticaNeue-Thin", size: 30)
        //firstRecent.textAlignment = .center
        view.addSubview(firstRecent)
        
        secondRecent = UILabel(frame: CGRect(x: 80, y: 360, width: view.frame.width - 160, height: 40))
        secondRecent.text = "2. \(recents[1]) "
        secondRecent.font =  UIFont (name: "HelveticaNeue-Thin", size: 30)
        //secondRecent.textAlignment = .center
        view.addSubview(secondRecent)
        
        thirdRecent = UILabel(frame: CGRect(x: 80, y:410, width: view.frame.width - 160, height: 40))
        thirdRecent.text = "3. \(recents[2]) "
        //thirdRecent.textAlignment = .center
        thirdRecent.font =  UIFont (name: "HelveticaNeue-Thin", size: 30)
        view.addSubview(thirdRecent)
        
        // Do any additional setup after loading the view.
        let lightBlue = UIColor(hue: 0.5667, saturation: 0.58, brightness: 0.96, alpha: 1.0)
        let midBlue = UIColor(hue: 0.5667, saturation: 0.72, brightness: 0.96, alpha: 1.0)
        let darkBlue = UIColor(hue: 0.5667, saturation: 0.82, brightness: 0.96, alpha: 1.0)
        backgroundColours = [lightBlue, midBlue, darkBlue]
        backgroundLoop = 0
        self.animateBackgroundColour()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false;
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
