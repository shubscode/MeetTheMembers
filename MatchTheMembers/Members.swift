//
//  Members.swift
//  MatchTheMembers
//
//  Created by Shubham Gupta on 2/7/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import Foundation
import UIKit

var memberToImage = [String: UIImage]()
let numMembers = members.count
var names = ["Daniel Andrews", "Nikhar Arora", "Tiger Chen", "Xin Yi Chen", "Julie Deng", "Radhika Dhomse", "Kaden Dippe", "Angela Dong", "Zach Govani", "Shubham Gupta", "Suyash Gupta", "Joey Hejna", "Cody Hsieh", "Stephen Jayakar", "Aneesh Jindal", "Mohit Katyal", "Mudabbir Khan", "Akkshay Khoslaa", "Justin Kim", "Eric Kong", "Abhinav Koppu", "Srujay Korlakunta", "Ayush Kumar", "Shiv Kushwah", "Leon Kwak", "Sahil Lamba", "Young Lin", "William Lu", "Louie McConnell", "Max Miranda", "Will Oakley", "Noah Pepper", "Samanvi Rai", "Krishnan Rajiyah", "Vidya Ravikumar", "Shreya Reddy", "Amy Shen", "Wilbur Shi", "Sumukh Shivakumar", "Fang Shuo", "Japjot Singh", "Victor Sun", "Sarah Tang", "Kanyes Thaker", "Aayush Tyagi", "Levi Walsh", "Carol Wang", "Sharie Wang", "Ethan Wong", "Natasha Wong", "Aditya Yadav", "Candice Ye", "Vineeth Yeevani", "Jeffery Zhang"]

var scores = [0]
var responses = [" ", " ", " "]
let members = names.sorted(by: <)

func lastThree() -> [String] {
    print(responses)
    var copy = responses
    let first = copy.removeLast()
    let second = copy.removeLast()
    let third = copy.removeLast()
    return [first, second, third]
}

func createOptions() -> [String] {
    var copy = members
    let rand1 = Int(arc4random_uniform(UInt32(copy.count)));
    let option1 = copy[rand1]
    
    copy.remove(at: rand1)
    let rand2 = Int(arc4random_uniform(UInt32(copy.count)));
    let option2 = copy[rand2]
    
    copy.remove(at: rand2)
    let rand3 = Int(arc4random_uniform(UInt32(copy.count)));
    let option3 = copy[rand3]
    
    copy.remove(at: rand3)
    let rand4 = Int(arc4random_uniform(UInt32(copy.count)));
    let option4 = copy[rand4]
    return [option1, option2, option3, option4]
}

func selectAnswer(options: [String]) -> String {
    return options[Int(arc4random_uniform(UInt32(options.count)))];
}

func findImages(name: String) -> UIImageView {
    let trimmedString = name.replacingOccurrences(of: " ", with: "")
    let newName = trimmedString.lowercased()
    let memberPicture = UIImage(named: newName)
    return UIImageView(image: memberPicture)
}

    

