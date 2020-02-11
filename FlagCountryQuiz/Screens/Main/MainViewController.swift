//
//  MainViewController.swift
//  FlagCountryQuiz
//
//  Created by Henrik on 2020-02-07.
//  Copyright © 2020 Henrik. All rights reserved.
//

import UIKit

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

class MainViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var myBtn: UIButton!
    var quizVC = QuizViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(700)) {
            self.present(self.quizVC, animated: true, completion: nil)
        }
        
        view.backgroundColor = .white
        myView.backgroundColor = .clear
        myBtn.backgroundColor = .white
        myBtn.layer.borderColor = UIColor.myPink.cgColor
        myBtn.setTitleColor(.myPink, for: .normal)
        myBtn.layer.borderWidth = 3
        myBtn.layer.cornerRadius = myBtn.bounds.height / 2
        logoLabel.textColor = .myPink
        
        
//        createParticles()
//        makeEmitterCell(color: .blue)
        
        
        
        
    }
    
    
    func createParticles() {
        let particleEmitter = CAEmitterLayer()
        
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
        particleEmitter.emitterShape = .line
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let red = makeEmitterCell(color: UIColor.red)
        let yellow = makeEmitterCell(color: UIColor.yellow)
        let cyan = makeEmitterCell(color: UIColor.cyan)
        let white = makeEmitterCell(color: UIColor.white)
        let purple = makeEmitterCell(color: UIColor.purple)
        
        particleEmitter.emitterCells = [red, yellow, cyan, white, purple]
        
        view.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 5
        cell.lifetime = 6.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 200
        cell.velocityRange = 80
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 1
        cell.spinRange = 3
        cell.scaleRange = 3.9
        cell.scaleSpeed = 1.2
        
        cell.contents = UIImage(named: "snowflake1")?.cgImage
        return cell
    }
    
}
