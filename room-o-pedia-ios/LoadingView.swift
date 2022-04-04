//
//  LoadingView.swift
//  room-o-pedia-ios
//
//  Created by Rachel H Lee on 4/3/22.
//

import UIKit

class LoadingView: UIView {
    
  //  let backgroundView = UIView()
    let circle1 = UIView()
    let circle2 = UIView()
    let circle3 = UIView()
    
    var circleArray: [UIView] = []
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        circleArray = [circle1, circle2, circle3]
        
        for circle in circleArray {
            circle.frame = CGRect(x: -20, y: 5, width: 30, height: 30)
            circle.layer.cornerRadius = 15
            circle.backgroundColor = .systemTeal
            
            circle.alpha = 0
            
            addSubview(circle)
        }
    }
    
    func animate() {
        var delay: Double = 0
        for circle in circleArray {
            animateCircle(circle, delay: delay)
            delay += 0.95
        }
    }
    
    func animateCircle(_ circle: UIView, delay: Double) {
        UIView.animate(withDuration: 0.8, delay: delay, options: .curveLinear, animations: {
            circle.alpha = 1
            circle.frame = CGRect(x: 35, y: 5, width: 30, height: 30)
        }) { (completed) in
            UIView.animate(withDuration: 1.3, delay: 0, options: .curveLinear, animations: {
                circle.frame = CGRect(x: 85, y: 5, width: 30, height: 30)
            }) { (completed) in
                UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear, animations: {
                    circle.alpha = 0
                    circle.frame = CGRect(x: 140, y: 5, width: 30, height: 30)
                }) { (completed) in
                    circle.frame = CGRect(x: -20, y: 5, width: 30, height: 30)
                    self.animateCircle(circle, delay: 0)
                }
            }
        }
    }
}
