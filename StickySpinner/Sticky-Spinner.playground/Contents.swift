//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import QuartzCore

class StickySpinner : UIView {
    
    var trackColor: UIColor = UIColor.lightGray {
        didSet {
            drawArc()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            drawArc()
        }
    }
    
    var thickness:CGFloat = 3 {
        didSet {
            drawArc()
        }
    }
    
    var rotationTime = 3.0 {
        didSet {
            addAnimation()
        }
    }
    
    private let startAngle:CGFloat = 0.0
    private let endAngle = CGFloat.pi*8/6.0
    private var arc = UIBezierPath()
    private var fullCircleLayer = CAShapeLayer()
    
    private let timingFunc = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if frame.width != frame.height {
            print("[!] ShoestringSpinner warning : frame width != height")
        }
        
        drawArc()
    }
    
    override func tintColorDidChange() {
        drawArc()
    }
    
    private func drawArc() {
        
        layer.sublayers = nil
        
        fullCircleLayer = CAShapeLayer()
        fullCircleLayer.contentsScale = layer.contentsScale
        fullCircleLayer.backgroundColor = UIColor.clear.cgColor
        fullCircleLayer.fillColor = UIColor.clear.cgColor
        fullCircleLayer.bounds = layer.bounds
        fullCircleLayer.position = layer.position
        fullCircleLayer.strokeColor = tintColor.cgColor
        fullCircleLayer.lineWidth = thickness/2 + (thickness/2 * 0.36)
        
        let radius = (bounds.size.width/2) - (thickness*5)/2 - 2
        
        fullCircleLayer.path = UIBezierPath(arcCenter:center , radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        
        layer.addSublayer(fullCircleLayer)
        
        addAnimation()
    }
    
    private func addAnimation() {
        
        fullCircleLayer.removeAnimation(forKey: "spin")
        fullCircleLayer.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // https://codepen.io/jczimm/pen/vEBpoL
        // rotate the circle in the opposite way of the stroke,
        // option to animate colors
        // timing curves may be difficult to get just right.
        
        animation.toValue = 0
        animation.fromValue = -2.0*CGFloat.pi
        animation.duration = rotationTime
        animation.repeatCount = Float.greatestFiniteMagnitude
        fullCircleLayer.add(animation, forKey: "spin")
        animation.timingFunction = timingFunc
        
        
        let snake = CABasicAnimation(keyPath: "strokeStart")
        snake.toValue = 0
        snake.fromValue = 1
        
        
        let widthAnim = CABasicAnimation(keyPath: "lineWidth")
        widthAnim.fromValue = thickness * 5
        widthAnim.toValue = thickness
        
        
        let group = CAAnimationGroup()
       
        group.duration = 2.5
        group.autoreverses = true
        group.repeatCount = Float.greatestFiniteMagnitude
        group.animations = [snake, widthAnim]
        group.timingFunction = timingFunc
        
        fullCircleLayer.add(group, forKey: "group")
    }
}

let spin = StickySpinner(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
spin.backgroundColor = UIColor.white
spin.thickness = 4
spin.rotationTime = 1.5
spin.tintColor = .black

PlaygroundPage.current.liveView = spin

