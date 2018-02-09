//
//  ViewController.swift
//  MatchTheMembers
//
//  Created by Shubham Gupta on 2/7/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var openingLabel: UILabel!
    var gameStartButton: UIButton!
    var openingImage: UIImage!
    
    var backgroundColours = [UIColor()]
    var backgroundLoop = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        openingImage = UIImage(named: "mdblogopng")
        let openingImageView = UIImageView(image: openingImage)
        openingImageView.frame = CGRect(x:view.frame.midX - 150, y:170, width: 300, height: 220)
        view.addSubview(openingImageView)

        openingLabel = UILabel(frame: CGRect(x:20, y:100, width: view.frame.width - 10, height: 50))
        openingLabel.text = "Match the Members"
        openingLabel.textColor = .white
        openingLabel.font = openingLabel.font.withSize(30)
        openingLabel.textAlignment = .center
        openingLabel.lineBreakMode = .byWordWrapping
        openingLabel.numberOfLines = 3
        view.addSubview(openingLabel)
        
        gameStartButton = UIButton(frame: CGRect(x: view.frame.midX - 100, y:420, width:200, height: 60))
        gameStartButton.setTitle("Lets Go!", for: .normal)
        gameStartButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Thin", size: 30)
        gameStartButton.addTarget(self, action: #selector(segue), for: .touchUpInside)
        view.addSubview(gameStartButton)
        
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
    
    @objc func segue() {
        self.performSegue(withIdentifier: "toGame", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
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


}

