//
//  ViewController.swift
//  vpn
//
//  Created by Roman Alikevich on 18.05.2021.
//

import UIKit

class ViewController: UIViewController {
    private static let DEFAULT_COUNTRY_VALUE = ""
//    var window: UIWindow?
    var pulseView = PulseView()
    var secondView: SecondViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondView = SecondViewController(nibName: nil, bundle: nil)
        view.backgroundColor = .white

        setUpNavigationController()
        
        secondView?.transmissCountryValue = { [unowned self] (countryName, countryUrl) in
            self.view.removeFromSuperview()
            setLaunchButton(countryName: countryName, countryUrl: countryUrl)
        }
        setLaunchButton()
    }
    
    func setUpNavigationController() {
        let menu = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(moveToSecondViewController))
        self.view.backgroundColor = UIColor.getColorByRgb(rgbValue: 0x24d7f7)
        self.navigationItem.setRightBarButton(menu, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.title = "Secure VPN"
    }
    
    func setLaunchButton(countryName: String = DEFAULT_COUNTRY_VALUE, countryUrl: String = DEFAULT_COUNTRY_VALUE) {
        if countryName != ViewController.DEFAULT_COUNTRY_VALUE {
            pulseView.setViewElements(name: countryName, iconUrl: countryUrl)
        } else {
            pulseView.setViewElements()
        }
//        pulseView.setViewElements(name: countryName, iconUrl: countryUrl)
        let subviewWidth = self.view.frame.width / 2.0
        pulseView.layer.cornerRadius = subviewWidth / 2

        self.view.addSubview(pulseView)
        pulseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pulseView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pulseView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            pulseView.widthAnchor.constraint(equalToConstant: subviewWidth),
            pulseView.heightAnchor.constraint(equalToConstant: subviewWidth)
        ])
        
        pulseVpnView()
    }
    
    func pulseVpnView() {
        let circulePath = UIBezierPath(arcCenter: .zero, radius: self.view.frame.size.width / 2, startAngle: 0.0, endAngle: 2 * .pi, clockwise: true)
        let pulseLayer = CAShapeLayer()
        pulseLayer.path = circulePath.cgPath
        pulseLayer.lineWidth = 10
        pulseLayer.fillColor = UIColor.clear.cgColor
        pulseLayer.strokeColor = UIColor.white.cgColor
        pulseLayer.lineCap = CAShapeLayerLineCap.round
        pulseLayer.position = CGPoint(x: self.view.frame.width / 4, y: self.view.frame.width / 4)
        pulseLayer.shadowColor = UIColor.white.cgColor
        pulseLayer.shadowOpacity = 0.5
        pulseLayer.shadowOffset = .zero
        pulseLayer.shadowRadius = 20
        pulseLayer.opacity = 0.5
        UIView.animate(withDuration: 10, delay: 0, options: .curveEaseOut) {
            pulseLayer.lineWidth += 20
            pulseLayer.opacity = 0.5
        } completion: { (true) in
            print("Done")
        }
        pulseVpnViewAnimation(pulseLayer: pulseLayer)
        pulseView.layer.addSublayer(pulseLayer)
    }
    
    func pulseVpnViewAnimation(pulseLayer: CAShapeLayer) {
        let animationView = CABasicAnimation(keyPath: "transform.scale")
        animationView.duration = 4.0
        animationView.fromValue = 0.5
333
        animationView.toValue = 2
        animationView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animationView.repeatCount = .greatestFiniteMagnitude
        pulseLayer.add(animationView, forKey: "scale")
//
        let opacityAnimationView = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimationView.duration = 4.0
        opacityAnimationView.fromValue = 2
        opacityAnimationView.toValue = 0.5
        opacityAnimationView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        opacityAnimationView.repeatCount = .greatestFiniteMagnitude
        pulseLayer.add(opacityAnimationView, forKey: "opacity")
    }
    
    @objc func moveToSecondViewController() {
        navigationController?.pushViewController(secondView!, animated: true)
    }
}

