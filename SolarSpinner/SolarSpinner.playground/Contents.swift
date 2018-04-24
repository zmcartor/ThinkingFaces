import UIKit
import PlaygroundSupport

class SolarSpinner : UIView {
    
    typealias threeIntTuple = (first:Int , second:Int, third:Int)
    
    var spacing:threeIntTuple = (first:15, second:20, third:30) {
        didSet {
            drawFigures()
        }
    }
    
    var masses:threeIntTuple = (first:15, second:15, third:10) {
        didSet {
            drawFigures()
        }
    }
    
    var sunRadius:Int = 20 {
        didSet {
            drawFigures()
        }
    }
    var bodyColors:(sun:UIColor, first:UIColor, second:UIColor, third:UIColor) = (sun: .yellow, first:.orange, second:.blue, third: .red)

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (frame.width != frame.height) {
            print("[!] SolarSpinner - frame isn't square")
        }
        
        drawFigures()
    }
    
    private func drawFigures() {
        layer.removeAllAnimations()
        layer.sublayers = nil
        
        let sun = drawSun()
        sun.strokeColor = UIColor.clear.cgColor
        layer.addSublayer(drawSun())
        
        layer.addSublayer(drawOrbitingPlanet(distanceFromSun: sunRadius + spacing.first,
                                             mass: masses.first,
                                             color: .orange,
                                             orbitalSpeed: 3))
        
        layer.addSublayer(drawOrbitingPlanet(distanceFromSun: sunRadius + spacing.first + spacing.second,
                                             mass: masses.second,
                                             color: .red,
                                             orbitalSpeed: 5))
        
        layer.addSublayer(drawOrbitingPlanet(distanceFromSun: sunRadius + spacing.first + spacing.second + spacing.third,
                                             mass: masses.third,
                                             color: .blue,
                                             orbitalSpeed: 8))
        // Animate the orbit color
        let base = CABasicAnimation(keyPath: "strokeColor")
        base.toValue = UIColor.darkGray.cgColor
        base.autoreverses = true
        base.repeatCount = Float.greatestFiniteMagnitude
        base.duration = 3
        base.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        var offset:Double = 0
        
        layer.sublayers?.forEach({ (layer) in
            guard let shape = layer as? CAShapeLayer else { return }
            offset += 0.05
            base.beginTime = CACurrentMediaTime() + offset
            shape.add(base, forKey: "orbitAnim")
        })
    }
    
    private func drawSun() -> CAShapeLayer {
        
        let shape = CAShapeLayer()
        shape.contentsScale = layer.contentsScale
        shape.frame = frame
        
        let sunFrame = CGRect(x: center.x - CGFloat(sunRadius), y: center.y - CGFloat(sunRadius) , width: CGFloat(sunRadius)*2, height: CGFloat(sunRadius)*2)
        
        shape.path = UIBezierPath(ovalIn: sunFrame).cgPath
        shape.strokeColor = bodyColors.sun.cgColor
        shape.fillColor = bodyColors.sun.cgColor
        
        return shape
    }
    
    private func drawOrbitingPlanet(distanceFromSun:Int , mass:Int , color:UIColor, orbitalSpeed:Int) -> CAShapeLayer {
        
        let shape = CAShapeLayer()
        shape.contentsScale = layer.contentsScale
        shape.frame = frame
        shape.backgroundColor = UIColor.clear.cgColor
        
        let path = UIBezierPath(arcCenter: center, radius: CGFloat(distanceFromSun), startAngle: 0, endAngle: CGFloat(Float.pi * 2.0), clockwise: true).cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        
        shape.path = path
        
        let planet = CAShapeLayer()
        planet.frame = CGRect(x: 0, y: 0, width: mass, height: mass)
        planet.contentsScale = layer.contentsScale
        planet.fillColor = color.cgColor
        planet.path = UIBezierPath(ovalIn: planet.frame).cgPath
        
        shape.addSublayer(planet)
        
        let timingFunc = CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
        
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.duration = CFTimeInterval(orbitalSpeed)
        anim.isAdditive = true
        anim.repeatCount = Float.greatestFiniteMagnitude
        anim.timingFunctions = [timingFunc, timingFunc, timingFunc, timingFunc]
        
        // because of how paths are drawn, and animated wrt Keyframe animations, we must add a little
        // to get the circle to follow within center
        anim.path = CGPath(ellipseIn:CGRect(x:center.x - CGFloat(distanceFromSun+mass/2) ,
                                            y:center.y - CGFloat(distanceFromSun+mass/2) ,
                                            width:CGFloat(distanceFromSun * 2),
                                            height: CGFloat(distanceFromSun * 2)), transform: .none)
        
        anim.rotationMode = kCAAnimationPaced
        planet.add(anim, forKey: "rotate")
        
        return shape
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = SolarSpinner(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
