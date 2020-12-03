//
//  ProgessBarHumid.swift
//  tabcontrol
//
//  Created by chia on 2019/12/20.
//  Copyright © 2019 chia. All rights reserved.
//

import UIKit

class ProgessBarHumid: UIView {
    
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    private var gradientLayer: CAGradientLayer!

    
    public var progress: CGFloat = 0 {
      didSet {
        didProgressUpdated()
      }
    }
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let re = WebService1()
        //let a1 = re.Roommm(ID: NSUserName()!)
        let er = re.value(item: "Hum", roomid: 102)
        let w :Float = Float(er)
        let w1 :Float = w/100.00
        // Drawing code
        let width = rect.width
        let height = rect.height
        
        let lineWidth = 0.1 * min(width, height)
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.gray.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.lineCap = .round
        foregroundLayer = CAShapeLayer()
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.strokeColor = UIColor.systemTeal.cgColor
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.lineCap = .round
//        layerPercentage()
        foregroundLayer.strokeEnd = CGFloat(w1)
       // foregroundLayer.strokeEnd = 0.25
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
        
        //layer.addSublayer(textLayer)
    }
   /* func layerPercentage(){
        
    }*/
    private func createCircularLayer(rect: CGRect, strokeColor: CGColor,
                                      fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
       
       let width = rect.width
       let height = rect.height
       
       let center = CGPoint(x: width / 2, y: height / 2)
       let radius = (min(width, height) - lineWidth) / 2
       
       let startAngle = -CGFloat.pi / 2
       let endAngle = startAngle + 2 * CGFloat.pi
       
       let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
       
       let shapeLayer = CAShapeLayer()
       
       shapeLayer.path = circularPath.cgPath
       
       shapeLayer.strokeColor = strokeColor
       shapeLayer.fillColor = fillColor
       shapeLayer.lineWidth = lineWidth
       shapeLayer.lineCap = .round
       
       return shapeLayer
     }
    private func createTextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer {
       
       let width = rect.width
       let height = rect.height
       
       let fontSize = min(width, height) / 4
       let offset = min(width, height) * 0.1

       let layer = CATextLayer()
       layer.string = "\(Int(progress * 100))"
       layer.backgroundColor = UIColor.clear.cgColor
       layer.foregroundColor = textColor
       layer.fontSize = fontSize
       layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset)
       layer.alignmentMode = .center
       
       return layer
     }

    private func didProgressUpdated() {
       textLayer?.string = "25"
       foregroundLayer?.strokeEnd = progress
     //   foregroundLayer.strokeEnd = 0.25
     }
     
    
}
