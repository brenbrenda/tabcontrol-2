//
//  ViewController.swift
//  tabcontrol
//
//  Created by chia on 2019/12/24.
//  Copyright © 2019 chia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let progressView: VerticalProgressView = {
        let pv = VerticalProgressView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        // Do any additional setup after loading the view.
    }
    private func setupViews() {
        view.addSubview(progressView)
        progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        progressView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        progressView.tintColor = .red
        progressView.backgroundColor = .darkText
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
