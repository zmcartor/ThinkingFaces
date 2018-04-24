import UIKit
import PlaygroundSupport

class Ringo : UIView {
    
    override static var layerClass: AnyClass {
        get {
            return CAShapeLayer.self
        }
    }
    
    var speed: Float = 5 {
        didSet {
            layer.speed = scale(speed)
        }
    }
    
    var entropy: Int = 5 {
        didSet {
            drawFigures()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            drawFigures()
        }
    }
    
    private func scale(_ value:Float) -> Float {
        
        guard value <= 10 else { return 10 }
        guard Double(value) >= 0.5 else { return 0.5 }
        
        let input_start:Float = 1.0
        let input_end:Float = 10.0
        let output_start:Float = 1.0
        let output_end:Float = 2.5
        
       return  (Float(value) - input_start) / (input_end - input_start) * (output_end - output_start) + output_start
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawFigures()
    }
    
    private func drawFigures() {
        layer.sublayers = nil
        
        let ember = drawCircle(radius: frame.width/2 - 5)
        ember.opacity = 0.5
        
        let replicator = CAReplicatorLayer()
        replicator.contentsScale = layer.contentsScale
        replicator.frame = frame
        replicator.backgroundColor = UIColor.clear.cgColor
        
        let copy = drawCircle(radius: frame.width/2 - 5)
        replicator.addSublayer(copy)
        
        replicator.instanceCount = (2 * entropy)
        replicator.instanceAlphaOffset = -0.05
        replicator.instanceDelay = 0.1
        replicator.instanceColor = tintColor.cgColor
        
        layer.addSublayer(replicator)
        layer.addSublayer(ember)

        let smallPath = UIBezierPath(arcCenter: center, radius: 10, startAngle: 0, endAngle: CGFloat.pi * 2.0, clockwise: true).cgPath
        
        let copyAnim = CABasicAnimation(keyPath: "path")
        copyAnim.duration = 1.5
       
        copyAnim.autoreverses = true
        copyAnim.fromValue = copy.path
        copyAnim.toValue = smallPath
        copyAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        copyAnim.repeatCount = Float.greatestFiniteMagnitude
        
        copy.add(copyAnim, forKey: "pulse")
        
        copyAnim.duration = 0.75
        ember.add(copyAnim, forKey: "pulse")
    }
    
    private func drawCircle(radius:CGFloat , filled:Bool = true) -> CAShapeLayer {
        let shape = CAShapeLayer()
        shape.contentsScale = layer.contentsScale
        shape.frame = layer.frame
        shape.backgroundColor = UIColor.clear.cgColor
        
        shape.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2.0 * CGFloat.pi, clockwise: true).cgPath
        
        shape.fillColor = filled ? tintColor.cgColor : UIColor.clear.cgColor
        shape.strokeColor = tintColor.cgColor
        
        return shape
    }
    
}
// Present the view controller in the Live View window
let ring = Ringo(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
ring.backgroundColor = .white
ring.entropy = 3
ring.speed = 1
ring.tintColor = UIColor.red
PlaygroundPage.current.liveView = ring
