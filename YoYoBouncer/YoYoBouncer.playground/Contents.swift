//: A UIKit based Playground for presenting user interface
  
import UIKit
import QuartzCore
import PlaygroundSupport

class YoYoBouncer : UIView {
    var speed = 1 {
        didSet {
            layer.speed = scale(speed)
        }
    }
    
    override func tintColorDidChange() {
        drawFigures()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawFigures()
    }
    
    private func scale(_ speed:Int) -> Float {
        
        guard speed <= 10 else { return 10 }
        guard Float(speed) >= 0.5 else { return 0.5 }
        
        let input_start:Float = 1.0
        let input_end:Float = 10.0
        let output_start:Float = 1
        let output_end:Float = 5
        
        return (Float(speed) - input_start) / (input_end - input_start) * (output_end - output_start) + output_start
    }
    
    private func drawFigures() {
        
        let small = drawCircle(radius: 10)
        small.frame.origin.y = 15
        
        let triangle = drawTriangle()
        let med = drawCircle(radius: 40)
        med.frame.origin.y += 50
        
        layer.addSublayer(small)
        layer.addSublayer(med)
        layer.addSublayer(triangle)
        
        let animSmall = CABasicAnimation(keyPath: "position")
        animSmall.toValue  = {
            var newPos = small.position
            newPos.y = frame.maxY - 40
            return newPos
            }()
        animSmall.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        animSmall.duration = 1.0
        animSmall.autoreverses = true
        animSmall.repeatCount = Float.greatestFiniteMagnitude
        small.add(animSmall, forKey: "animSmall")
        
        let animMed = CABasicAnimation(keyPath: "position")
        animMed.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animMed.toValue = {
            var newPos = med.position
            newPos.y = frame.minY + 55
            return newPos
        }()
        
        animMed.duration = 1.0
        animMed.autoreverses = true
        animMed.repeatCount = Float.greatestFiniteMagnitude
        med.add(animMed, forKey: "animMed")
        
        let animTri = CABasicAnimation(keyPath: "position")
        animTri.toValue = {
            var newPos = triangle.position
            newPos.y -= 100
            return newPos
        }()
        
        animTri.autoreverses = true
        animTri.repeatCount = Float.greatestFiniteMagnitude
        animTri.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        animTri.duration = 1.0
        animTri.autoreverses = true
        animTri.repeatCount = Float.greatestFiniteMagnitude
        triangle.add(animTri, forKey: "animTri")
        
        let triPath = UIBezierPath()
        triPath.move(to: CGPoint(x:10, y: frame.height-10))
        var to = center
        to.y += 70
        triPath.addLine(to:to)
        triPath.addLine(to: CGPoint(x:frame.width-10, y: frame.height-10))
        
        let swoopAnim = CABasicAnimation(keyPath: "path")
        swoopAnim.toValue = triPath.cgPath
        swoopAnim.duration = 1.0
        swoopAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        swoopAnim.autoreverses = true
        swoopAnim.repeatCount = Float.greatestFiniteMagnitude
        triangle.add(swoopAnim, forKey: "swoop")
    }
    
    private func drawCircle(radius:CGFloat) -> CAShapeLayer {
        
        let circle = CAShapeLayer()
        circle.contentsScale = layer.contentsScale
        circle.fillColor = UIColor.orange.cgColor
        circle.strokeColor = UIColor.orange.cgColor
        
        circle.frame = CGRect(x: (frame.width-radius)/2, y: (frame.height-radius)/2, width: radius, height: radius)
        circle.path = UIBezierPath(arcCenter: CGPoint(x:radius/2, y:radius/2), radius: radius, startAngle: 0, endAngle: 2.0*CGFloat.pi, clockwise: true).cgPath
        
        return circle
    }
    
    private func drawTriangle() -> CAShapeLayer {
        let triangle = CAShapeLayer()
        triangle.contentsScale = layer.contentsScale
        triangle.frame = layer.frame
        
        let triPath = UIBezierPath()
        triPath.move(to: CGPoint(x:10, y: frame.height-10))
        var to = center
        to.y += 50
        triPath.addLine(to:to)
        triPath.addLine(to: CGPoint(x:frame.width-10, y: frame.height-10))
        triangle.path = triPath.cgPath
        triangle.fillColor = UIColor.clear.cgColor
        triangle.strokeColor = UIColor.white.cgColor
        triangle.lineWidth = 1
        return triangle
    }
}

let yoyo = YoYoBouncer(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
yoyo.speed = 1

PlaygroundPage.current.liveView = yoyo
