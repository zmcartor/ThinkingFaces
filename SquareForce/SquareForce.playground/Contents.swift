//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class SquareSpinner : UIView {
    
    var circleDiameter:Int = 55 {
        didSet {
            drawFigures()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            drawFigures()
        }
    }
    
    override static var layerClass: AnyClass {
        get {
            return CAShapeLayer.self
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (frame.width != frame.height){
            print("[!] SquareSpinner height not equal to width")
        }
        
        drawFigures()
    }
    
    private func drawFigures() {
        
        let shape = layer as! CAShapeLayer

        // Ensure the circle doesn't clip. Compute inset via pythagorean
        let inset = CGFloat(pow(frame.width, 2) + pow(frame.height, 2)).squareRoot() / 8
        
        let square = frame.insetBy(dx: inset + CGFloat(circleDiameter/2), dy: inset + CGFloat(circleDiameter/2))
        
        shape.path = UIBezierPath(rect: square).cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 1
        
        let circle = CAShapeLayer()
        
        circle.frame = CGRect(x:0, y:0, width: CGFloat(circleDiameter), height: CGFloat(circleDiameter))
        circle.contentsScale = layer.contentsScale
        circle.fillColor = tintColor.cgColor
        circle.path = UIBezierPath(ovalIn: circle.frame).cgPath
        shape.addSublayer(circle)
        
        let timingFunc = CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
        
        let rotateAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnim.duration = 3
        rotateAnim.toValue = Double.pi * 2
        rotateAnim.repeatCount = Float.greatestFiniteMagnitude
        rotateAnim.timingFunction = timingFunc
        
        layer.add(rotateAnim, forKey: "rotate")
        
        let moveAnim = CAKeyframeAnimation(keyPath: "position")
        var pathRect = square
        pathRect.origin.x -= CGFloat(circleDiameter/2)
        pathRect.origin.y -= CGFloat(circleDiameter/2)
        
        moveAnim.path = UIBezierPath(rect:pathRect).cgPath
        moveAnim.duration = 3
        moveAnim.isAdditive = true
        moveAnim.repeatCount = Float.greatestFiniteMagnitude
        
        moveAnim.timingFunctions = [timingFunc, timingFunc, timingFunc, timingFunc]
        
        circle.add(moveAnim, forKey: "moveCircle")
    }
    
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = SquareSpinner(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
