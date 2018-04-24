//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class FlowerSpinner : UIView {
    
    // speed 1..10. Faster speed equals faster animation. Animation timed between 0.5 (10 speed) to 3 (1 speed)
    var speed = 1 {
        didSet {
            drawDesign()
        }
    }
    var numberOfCircles = 30 {
        didSet {
            drawDesign()
        }
    }
    override class var layerClass: AnyClass {
        get {
            return CAReplicatorLayer.self
        }
    }
    
    override func tintColorDidChange() {
        drawDesign()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawDesign()
    }
    
    // bigger speed = faster spinning up to 10
    private func scale(_ speed:Int) -> Double {
        
        guard speed <= 10 else { return 10 }
        guard Double(speed) >= 0.5 else { return 0.5 }
        
        let input_start = 1.0
        let input_end = 10.0
        let output_start = 3.0
        let output_end = 0.5
        
        return (Double(speed) - input_start) / (input_end - input_start) * (output_end - output_start) + output_start
    }
    
    private func drawDesign() {
        
        layer.removeAllAnimations()
        layer.sublayers = nil
        
        let replicatorLayer = layer as! CAReplicatorLayer
        
        // the layer that we are replicating
        
        let shape = CAShapeLayer()
        shape.fillColor = tintColor.cgColor
        shape.lineWidth = 1
        shape.strokeColor = UIColor.clear.cgColor
        shape.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 12)).cgPath

        shape.position = CGPoint(x: 6, y: (layer.frame.height-12)/2.0)
        replicatorLayer.addSublayer(shape)
        shape.opacity = 0
        
        let duration = scale(speed)
        
        let instanceCount = numberOfCircles
        replicatorLayer.instanceCount = instanceCount
        replicatorLayer.instanceDelay = duration / CFTimeInterval(instanceCount)
        
        let angle = (CGFloat.pi * 2.0 / CGFloat(instanceCount))
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        let fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.fromValue = 1
        fadeOut.toValue = 0
        fadeOut.duration = duration
        fadeOut.repeatCount = Float.greatestFiniteMagnitude
        shape.add(fadeOut, forKey: nil)
    }
}

let anim = FlowerSpinner(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
anim.backgroundColor = UIColor.white
anim.speed = 9
anim.numberOfCircles = 100
anim.tintColor = UIColor.lightGray


// Present the view controller in the Live View window
PlaygroundPage.current.liveView = anim
