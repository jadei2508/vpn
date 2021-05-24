//
//  ViewController.swift
//  vpn
//
//  Created by Roman Alikevich on 18.05.2021.
//

import UIKit
import Cartography

class ViewController: UIViewController {
    private static let DEFAULT_COUNTRY_VALUE = ""
    private static let NAVIGATION_RIGHT_BUTTON_VALUE = "Menu"
    private static let NAVIGATION_TITLE_VALUE = "Secure VPN"
    private static let UI_VIEW_DIVIDER = 2
    private static let BACKGROUND_COLOR_UIINT = 0x24d7f7
    var pulseView = PulseView()
    var secondView: SecondViewController?
    var timeManager: TimeManager?
    var flag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeManager = TimeManager()
        pulseView = PulseView()
        secondView = SecondViewController(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        
        setUpNavigationController()
        
        secondView?.transmissCountryValue = { [unowned self] (countryName, countryUrl) in
            self.view.removeFromSuperview()
            setLaunchButton(countryName: countryName, countryUrl: countryUrl)
        }
        setLaunchButton()
        
        timeManager?.timeTransmiss = { [unowned self] (time) in
            pulseView.changeTimerValue(time: time)
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler(_:)))
        pulseView.addGestureRecognizer(tapRecognizer)
    }
    
    func setUpNavigationController() {
        let menu = UIBarButtonItem(title: ViewController.NAVIGATION_RIGHT_BUTTON_VALUE, style: .plain, target: self, action: #selector(moveToSecondViewController))
        self.view.backgroundColor = UIColor.getColorByRgb(rgbValue: UInt(ViewController.BACKGROUND_COLOR_UIINT))
        self.navigationItem.setRightBarButton(menu, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.title = ViewController.NAVIGATION_TITLE_VALUE
    }
    
    func setLaunchButton(countryName: String = DEFAULT_COUNTRY_VALUE, countryUrl: String = DEFAULT_COUNTRY_VALUE) {
        if countryName != ViewController.DEFAULT_COUNTRY_VALUE {
            pulseView.setViewElements(name: countryName, iconUrl: countryUrl)
        } else {
            pulseView.setViewElements()
        }
        let subviewWidth = self.view.frame.width / CGFloat(ViewController.UI_VIEW_DIVIDER)
        pulseView.layer.cornerRadius = subviewWidth / CGFloat(ViewController.UI_VIEW_DIVIDER)
        
        self.view.addSubview(pulseView)
        pulseView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pulseView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pulseView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            pulseView.widthAnchor.constraint(equalToConstant: subviewWidth),
            pulseView.heightAnchor.constraint(equalToConstant: subviewWidth)
        ])
    }
    
    func pulseVpnView() {
        let circulePath = UIBezierPath(arcCenter: .zero, radius: self.view.frame.size.width / CGFloat(ViewController.UI_VIEW_DIVIDER), startAngle: CGFloat(ShapeLayerInstance.SHAPE_LAYER_START_ANGLE.rawValue), endAngle: 2 * .pi, clockwise: true)
        let pulseLayer = CAShapeLayer()
        pulseLayer.path = circulePath.cgPath
        pulseLayer.lineWidth = CGFloat(ShapeLayerInstance.SHAPE_LAYER_LINE_WIDTH.rawValue)
        pulseLayer.fillColor = UIColor.clear.cgColor
        pulseLayer.strokeColor = UIColor.white.cgColor
        pulseLayer.lineCap = CAShapeLayerLineCap.round
        pulseLayer.position = CGPoint(x: self.view.frame.width / CGFloat(ShapeLayerInstance.SHAPE_LAYER_POSITION_DIVIDER.rawValue), y: self.view.frame.width / CGFloat(ShapeLayerInstance.SHAPE_LAYER_POSITION_DIVIDER.rawValue))
        pulseLayer.shadowColor = UIColor.white.cgColor
        pulseLayer.shadowOpacity = ShapeLayerInstance.SHAPE_LAYER_SHADOW_OPACITY.rawValue
        pulseLayer.shadowOffset = .zero
        pulseLayer.shadowRadius = CGFloat(ShapeLayerInstance.SHAPE_LAYER_SHADOW_RADIUS.rawValue)
        pulseLayer.opacity = ShapeLayerInstance.SHAPE_LAYER_SHADOW_OPACITY.rawValue
      
        pulseVpnViewAnimation(pulseLayer: pulseLayer)
        pulseView.layer.addSublayer(pulseLayer)
    }
    
    func pulseVpnViewAnimation(pulseLayer: CAShapeLayer) {
        let animationView = CABasicAnimation(keyPath: BasicAnimationKeyPath.INIT_BASIC_ANIMATION_KEY_PATH)
        animationView.duration = CFTimeInterval(BasicAnimationInstance.BASIC_ANIMATION_DURATION.rawValue)
        animationView.fromValue = BasicAnimationInstance.BASIC_ANIMATION_VALUE_FROM.rawValue
        animationView.toValue = BasicAnimationInstance.BASIC_ANIMATION_VALUE_TO.rawValue
        animationView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animationView.repeatCount = .greatestFiniteMagnitude
        pulseLayer.add(animationView, forKey: BasicAnimationKeyPath.SCALE_BASIC_ANIMATION_KEY_PATH)
        
        let opacityAnimationView = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimationView.duration = CFTimeInterval(BasicAnimationInstance.BASIC_ANIMATION_DURATION.rawValue)
        opacityAnimationView.fromValue = BasicAnimationInstance.BASIC_ANIMATION_VALUE_TO.rawValue
        opacityAnimationView.toValue = BasicAnimationInstance.BASIC_ANIMATION_VALUE_FROM.rawValue
        opacityAnimationView.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        opacityAnimationView.repeatCount = .greatestFiniteMagnitude
        pulseLayer.add(opacityAnimationView, forKey: BasicAnimationKeyPath.OPACITY_BASIC_ANIMATION_KEY_PATH)
    }
    
    @objc func moveToSecondViewController() {
        timeManager?.pause()
        timeManager?.timerClear()
        pulseView.layer.sublayers?.forEach {
            if $0.isKind(of: CAShapeLayer.self) {
                $0.removeFromSuperlayer()
            }
        }
        navigationController?.pushViewController(secondView!, animated: true)
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    @objc func tapHandler(_ tapGestureRecognizer: UITapGestureRecognizer? = nil) {
        if flag == 0 {
            pulseVpnView()
            timeManager?.startTimer()
            flag += 1
        } else {
            timeManager?.pause()
            pulseView.layer.sublayers?.forEach {
                if $0.isKind(of: CAShapeLayer.self) {
                    $0.removeFromSuperlayer()
                }
            }
            flag -= 1
        }
    }
}
