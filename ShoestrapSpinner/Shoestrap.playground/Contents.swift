//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import QuartzCore

class ShoestrapSpinner : UIView {
    
    var trackColor: UIColor = UIColor.lightGray {
        didSet {
            drawArcs()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            drawArcs()
        }
    }
    
    var thickness:CGFloat = 3 {
        didSet {
            drawArcs()
        }
    }
    
    var rotationTime = 3.0 {
        didSet {
            addAnimation()
        }
    }
    
    private let startAngle = CGFloat.pi*7.0/12.0
    private let endAngle = CGFloat.pi*5.0/12.0
    
    private var outerArc = UIBezierPath()
    private var innerArc = UIBezierPath()
    
    private var fullCircleLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if frame.width != frame.height {
            print("[!] ShoestringSpinner warning : frame width != height")
        }
        
        drawArcs()
    }
    
    override func tintColorDidChange() {
        drawArcs()
    }
    
    private func drawArcs() {
     
        layer.sublayers = nil
        
        fullCircleLayer = CAShapeLayer()
        trackLayer = CAShapeLayer()
        
        fullCircleLayer.contentsScale = layer.contentsScale
        trackLayer.contentsScale = layer.contentsScale
        
        fullCircleLayer.backgroundColor = UIColor.clear.cgColor
        trackLayer.backgroundColor = UIColor.clear.cgColor
        
        fullCircleLayer.fillColor = UIColor.clear.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        
        fullCircleLayer.bounds = layer.bounds
        trackLayer.bounds = layer.bounds
        
        fullCircleLayer.position = layer.position
        trackLayer.position = layer.position
        
        fullCircleLayer.strokeColor = tintColor.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        
        fullCircleLayer.lineWidth = thickness/2 + (thickness/2 * 0.36)
        trackLayer.lineWidth = thickness
        
        let radius = (bounds.size.width/2) - thickness/2 - 2
        
        fullCircleLayer.path = UIBezierPath(arcCenter:center , radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        
        trackLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true).cgPath
        
        layer.addSublayer(trackLayer)
        layer.addSublayer(fullCircleLayer)
        
        addAnimation()
    }
    
    private func addAnimation() {
            
        fullCircleLayer.removeAnimation(forKey: "spin")
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        animation.toValue = 0
        animation.fromValue = -2.0*CGFloat.pi
        animation.duration = rotationTime
        animation.repeatCount = Float.greatestFiniteMagnitude
        fullCircleLayer.add(animation, forKey: "spin")
    }
}

let spin = ShoestrapSpinner(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
spin.backgroundColor = UIColor.white
spin.thickness = 100
spin.rotationTime = 1

PlaygroundPage.current.liveView = spin
