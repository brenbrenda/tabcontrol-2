//
//  VerticalProgressView.swift
//  tabcontrol
//
//  Created by chia on 2019/12/24.
//  Copyright © 2019 chia. All rights reserved.
//
import UIKit

open class VerticalProgressView: UIView {
    private let progressView: UIProgressView = {
        let re = WebService1()
        let aa = re.value(item: "Tem", roomid: 102)
        var w :Float = Float(aa)
        var w1 :Float = w/60.00
        let progressView = UIProgressView()
        
        progressView.progress = w1//print temperature
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        addSubview(progressView)
//        let width = bounds.width
//        let height = bounds.height
        progressView.bounds.size.width = bounds.width
        progressView.bounds.size.height = bounds.height
        progressView.center.x = bounds.midX
        progressView.center.y = bounds.midY
        rotateProgressView()
        progressView.tintColor = .orange
        progressView.backgroundColor = .gray
        
    }
    private func rotateProgressView(){
        progressView.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
    }
}
